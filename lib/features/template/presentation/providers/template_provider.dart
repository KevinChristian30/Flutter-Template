import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/core/connection/network_info.dart';
import 'package:flutter_template/core/errors/failures.dart';
import 'package:flutter_template/core/params/params.dart';
import 'package:flutter_template/features/template/business/entities/template_entity.dart';
import 'package:flutter_template/features/template/business/usecases/get_template.dart';
import 'package:flutter_template/features/template/data/datasources/template_local_datasource.dart';
import 'package:flutter_template/features/template/data/datasources/template_remote_datasource.dart';
import 'package:flutter_template/features/template/data/repositories/template_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TemplateProvider extends ChangeNotifier {
  TemplateEntity? template;
  Failure? failure;

  TemplateProvider({
    this.template,
    this.failure,
  });

  void eitherFailureOrTemplate() async {
    TemplateRepositoryImpl repository = TemplateRepositoryImpl(
      remoteDataSource: TemplateRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: TemplateLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),
      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrTemplate = await GetTemplate(templateRepository: repository).call(
      templateParams: TemplateParams(),
    );

    failureOrTemplate.fold(
      (Failure newFailure) {
        template = null;
        failure = newFailure;
        notifyListeners();
      },
      (TemplateEntity newTemplate) {
        template = newTemplate;
        failure = null;
        notifyListeners();
      },
    );
  }
}
