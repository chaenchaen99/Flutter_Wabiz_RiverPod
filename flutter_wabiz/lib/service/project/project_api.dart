import 'package:dio/dio.dart';
import 'package:flutter_wadiz_riverpod/model/project/project_model.dart';
import 'package:flutter_wadiz_riverpod/model/project/reward_model.dart';
import 'package:flutter_wadiz_riverpod/shared/model/response_model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'project_api.g.dart';

@RestApi(baseUrl: "http://localhost:3000/api/v1")
abstract class ProjectApiClient {
  factory ProjectApiClient(Dio dio, {String baseUrl}) = _ProjectApiClient;

  @POST("/project")
  Future<ResponseModel> createProject(
    @Body() ProjectItemModel body,
  );

  @PUT("/project/{id}")
  Future<ResponseModel> updateProjectOpenState(
    @Path() String id,
    @Body() ProjectItemModel body,
  );

  @DELETE("/project/{id}")
  Future<ResponseModel> deleteProject(
    @Path() String id,
  );

  @GET("/project/user/{userId}")
  Future<ProjectModel> getProjectMyUserId(
    @Path() String userId,
  );

  @POST("/project/reward/{id}")
  Future<ResponseModel> createProjectReward(
    @Path() String id,
    @Body() RewardItemModel body,
  );
}
