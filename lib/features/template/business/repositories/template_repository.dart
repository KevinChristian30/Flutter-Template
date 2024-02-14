import 'package:dartz/dartz.dart';
import 'package:flutter_template/core/errors/failures.dart';
import 'package:flutter_template/core/params/params.dart';
import 'package:flutter_template/features/template/business/entities/template_entity.dart';

abstract class TemplateRepository {
  Future<Either<Failure, TemplateEntity>> getTemplate({
    required TemplateParams templateParams,
  });
}
