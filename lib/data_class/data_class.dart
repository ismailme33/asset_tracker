import 'dart:io';
import 'package:asset_tracker/data_class/assets_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AssetsListItems {
  final _fireStoreDatabase = FirebaseFirestore.instance;

  // Upload a single product to Firestore
  Future<void> uploadProducts(AssetsModel asset) async {
    final doucmenta = _fireStoreDatabase.collection('Assets list').doc();
    asset.id = doucmenta.id;

    doucmenta.set(asset.toMap()).then(
      (value) {
        debugPrint('Product is uploaded');
      },
    ).onError(
      (error, stackTrace) {
        debugPrint(error.toString());
      },
    );
  }

  // Fetch products from Firestore
  Future<List<AssetsModel>> fetchProducts() async {
    try {
      final fetchedAssets =
          await _fireStoreDatabase.collection('Assets list').get();

      List<AssetsModel> allAssets = fetchedAssets.docs.map((e) {
        var data = e.data() as Map<String, dynamic>;

        // Convert Timestamp fields to DateTime
        if (data['purchasedate'] is Timestamp) {
          data['purchasedate'] = (data['purchasedate'] as Timestamp).toDate();
        }
        if (data['assigneddate'] is Timestamp) {
          data['assigneddate'] = (data['assigneddate'] as Timestamp).toDate();
        }
        if (data['createddate'] is Timestamp) {
          data['createddate'] = (data['createddate'] as Timestamp).toDate();
        }

        return AssetsModel.fromMap(data);
      }).toList();

      return allAssets;
    } catch (e) {
      print("Error fetching assets: $e");
      return [];
    }
  }

  // Import data from an Excel file
  // Import data from an Excel file
  Future<void> importFromExcel() async {
    try {
      // Open file picker to select an Excel file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result == null) return; // No file selected
      final File file = File(result.files.single.path!);

      // Read the Excel file
      final bytes = file.readAsBytesSync();
      final excel = Excel.decodeBytes(bytes);

      // Loop through each sheet in the Excel file
      for (var table in excel.tables.keys) {
        final sheet = excel.tables[table];
        if (sheet == null) continue;

        debugPrint("Processing sheet: $table");

        // Process each row in the sheet
        for (var i = 0; i < sheet.rows.length; i++) {
          final row = sheet.rows[i];

          // Skip empty rows and the header row
          if (row.isEmpty || i == 0) {
            debugPrint("Skipping row $i (header or empty).");
            continue;
          }

          try {
            // Helper function to convert each cell value to String
            String? getString(dynamic value) => value?.value?.toString();

            // Map Excel row data to AssetsModel
            final asset = AssetsModel(
              id: Uuid.NAMESPACE_OID,
              assetType: getString(row[0]) ?? '',
              brand: getString(row[1]) ?? '',
              sn: getString(row[2]) ?? '',
              imeiNumber: getString(row[3]) ?? '',
              deviceModel: getString(row[4]) ?? '',
              assetname: getString(row[5]) ?? '',
              processor: getString(row[6]) ?? '',
              ram: getString(row[7]) ?? '',
              hardDrive: getString(row[8]) ?? '',
              displaySize: getString(row[9]) ?? '',
              purchasedDate: getString(row[10]) != null
                  ? DateTime.tryParse(getString(row[16])!)
                  : null,
              warrantyPeriod: getString(row[11]) ?? '',
              notes: getString(row[12]) ?? '',
              assignee: getString(row[13]) ?? '',
              status: getString(row[14]) ?? '',
              substatus: getString(row[15]) ?? '',
              assignedDate: getString(row[16]) != null
                  ? DateTime.tryParse(getString(row[16])!)
                  : null,
              localITSite: getString(row[17]) ?? '',
              location: getString(row[18]) ?? '',
              legalentity: getString(row[19]) ?? '',
              supplier: getString(row[20]) ?? '',
              supportPeriod: getString(row[21]) ?? '',
              sapnumber: getString(row[22]) ?? '',
              invNumber: getString(row[23]) ?? '',
              assetNumber: getString(row[24]) ?? '',
              createdDate: DateTime.now(),
            );

            // Debug print the mapped asset
            debugPrint("Mapped Asset: ${asset.toMap()}");

            // Upload each asset to Firestore
            await uploadProducts(asset);
          } catch (e) {
            debugPrint("Error processing row $i: $e");
          }
        }
      }

      debugPrint("Excel data uploaded successfully.");
    } catch (e) {
      debugPrint("Error importing Excel: $e");
    }
  }

  Future<void> updateProduct(String id, Map<String, dynamic> data) async {
    debugPrint("Updating product with data: $data");
    await _fireStoreDatabase
        .collection('Assets list')
        .doc(id)
        .update(data)
        .then(
      (value) {
        debugPrint('Product is updated');
      },
    ).onError(
      (error, stackTrace) {
        debugPrint(error.toString());
      },
    );
  }

  Future<Map<String, int>> fetchAssetCountsByType() async {
    try {
      final fetchedAssets =
          await _fireStoreDatabase.collection('Assets list').get();

      List<AssetsModel> allAssets = fetchedAssets.docs.map((e) {
        var data = e.data() as Map<String, dynamic>;

        // Convert Timestamp fields to DateTime
        if (data['purchasedate'] is Timestamp) {
          data['purchasedate'] = (data['purchasedate'] as Timestamp).toDate();
        }
        if (data['assigneddate'] is Timestamp) {
          data['assigneddate'] = (data['assigneddate'] as Timestamp).toDate();
        }
        if (data['createddate'] is Timestamp) {
          data['createddate'] = (data['createddate'] as Timestamp).toDate();
        }

        return AssetsModel.fromMap(data);
      }).toList();

      // Print all fetched assets for debugging
      print("Fetched assets: $allAssets");

      // Filter assets with status = "new"
      List<AssetsModel> newAssets = allAssets
          .where((asset) => asset.status != null && asset.status == "New")
          .toList();

      // Print filtered assets with status "new"
      print("Filtered new assets: $newAssets");

      // Count assets per assetType
      Map<String, int> assetCounts = {};
      for (var asset in newAssets) {
        if (asset.assetType != null) {
          // Print asset type for debugging
          print("Asset type: ${asset.assetType}");

          assetCounts[asset.assetType!] =
              (assetCounts[asset.assetType!] ?? 0) + 1;
        }
      }

      // Print the final count map for debugging
      print("Asset counts: $assetCounts");

      return assetCounts;
    } catch (e) {
      print("Error fetching assets: $e");
      return {};
    }
  }
}
