import 'package:project/data/constants/data_constants.dart';
import 'package:project/data/remote/api/rest_api_client.dart';
import 'package:project/data/remote/model/module_lead/lead_approve_cancel_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_contacted_via_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_create_edit_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_list_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_products_dto.dart';
import 'package:project/data/remote/model/login_details_dto.dart';
import 'package:project/main.dart';

abstract class ModuleLeadRepository {
  Future<List<LoginDetailsDTO>> getUserByMobileNo(String mobileNo);

  Future<List<LeadContactedViaDTO>?> getContactedViaDetails();

  Future<List<LeadProductsDTO>?> getProducts();

  Future<List<LeadListDTO>?> getLeads();

  Future<String> createLead(LeadCreateEditDTO leadCreateEditDTO);

  Future<String> editCreatedLead(LeadCreateEditDTO leadCreateEditDTO);

  Future<LeadDTO?> getCreatedLeadById(int? id);

  Future<String> createAcceptedLead(LeadApproveCancelDTO leadApproveCancelDTO);

  Future<String> createCancelledLead(LeadApproveCancelDTO leadApproveCancelDTO);
}

class ModuleLeadRepositoryImpl implements ModuleLeadRepository {
  final RestApiClient api;
  final String bearerToken = DataConstants.BEARER_TOKEN_PREFIX + MyApp.bearerToken;

  ModuleLeadRepositoryImpl({required this.api});

  @override
  Future<List<LoginDetailsDTO>> getUserByMobileNo(String mobileNo) {
    return api.getUserByMobileNo(bearerToken, mobileNo);
  }

  @override
  Future<List<LeadContactedViaDTO>?> getContactedViaDetails() {
    return api.getContactedViaDetails(bearerToken);
  }

  @override
  Future<List<LeadProductsDTO>?> getProducts() {
    return api.getProducts(bearerToken);
  }

  @override
  Future<List<LeadListDTO>?> getLeads() {
    return api.getLeads(bearerToken);
  }

  @override
  Future<String> createLead(LeadCreateEditDTO leadCreateEditDTO) {
    return api.createLead(bearerToken, leadCreateEditDTO);
  }

  @override
  Future<String> editCreatedLead(LeadCreateEditDTO leadCreateEditDTO) {
    return api.editCreatedLead(bearerToken, leadCreateEditDTO);
  }

  @override
  Future<LeadDTO?> getCreatedLeadById(int? id) {
    return api.getCreatedLeadById(bearerToken, id);
  }

  @override
  Future<String> createAcceptedLead(LeadApproveCancelDTO leadApproveCancelDTO) {
    return api.createAcceptedLead(bearerToken, leadApproveCancelDTO);
  }

  @override
  Future<String> createCancelledLead(LeadApproveCancelDTO leadApproveCancelDTO) {
    return api.createCancelledLead(bearerToken, leadApproveCancelDTO);
  }
}
