import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:project/data/remote/model/module_lead/lead_approve_cancel_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_contacted_via_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_create_edit_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_list_dto.dart';
import 'package:project/data/remote/model/module_lead/lead_products_dto.dart';
import 'package:project/data/remote/model/login_details_dto.dart';
import 'package:project/data/remote/model/sample_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_api_client.g.dart';

@RestApi()
abstract class RestApiClient {
  factory RestApiClient(Dio dio, {String? baseUrl}) = _RestApiClient;

  @GET("https://api.quotable.io/quotes")
  Future<SampleQuotableDTO> getQuotableList(@Query("page") int? page, @Query("limit") int? limit);

  @POST("post")
  Future<HttpBinResponse> postFileWithProgress(@Part() File file, @SendProgress() ProgressCallback? sendProgress);

  @GET("http://download2388.mediafire.com/f1uref0gg7sg/6lpmug32seosroc/YSR-Vidiyal.pdf")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getFileWithProgress(@ReceiveProgress() ProgressCallback? receiveProgress);

  @POST("post")
  Future<HttpBinResponse> postHttpBinFileAndJson(@Part(name: "json") SampleQuotableDTOResults sampleQuotableDTOResults, @Part() File file);

  @POST("bearer token sample")
  Future<bool> withBearerToken(@Header("Authorization") String token, @Query("page") int? page, @Query("limit") int? limit);

  // module lead start
  @GET("api/silktracker/GetUserByMobileNo")
  Future<List<LoginDetailsDTO>> getUserByMobileNo(@Header("Authorization") String token, @Query("MobileNo") String mobileNo);

  @GET("api/silktracker/GetContactedViaDetails")
  Future<List<LeadContactedViaDTO>?> getContactedViaDetails(@Header("Authorization") String token);

  @GET("api/silktracker/GetProducts")
  Future<List<LeadProductsDTO>?> getProducts(@Header("Authorization") String token);

  @GET("api/silktracker/GetLeads")
  Future<List<LeadListDTO>?> getLeads(@Header("Authorization") String token);

  @POST("api/silktracker/CreateLead")
  Future<String> createLead(@Header("Authorization") String token, @Body() LeadCreateEditDTO leadCreateEditDTO);

  @POST("api/silktracker/EditCreatedLead")
  Future<String> editCreatedLead(@Header("Authorization") String token, @Body() LeadCreateEditDTO leadCreateEditDTO);

  @GET("api/silktracker/GetCreatedLeadById/{Id}")
  Future<LeadDTO?> getCreatedLeadById(@Header("Authorization") String token, @Path("Id") int? id);

  @POST("api/silktracker/CreateAcceptedLead")
  Future<String> createAcceptedLead(@Header("Authorization") String token, @Body() LeadApproveCancelDTO leadApproveCancelDTO);

  @POST("api/silktracker/CreateCancelledLead")
  Future<String> createCancelledLead(@Header("Authorization") String token, @Body() LeadApproveCancelDTO leadApproveCancelDTO);

}
