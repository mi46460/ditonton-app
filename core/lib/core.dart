library core;

//utils
export 'utils/constants.dart';
export 'utils/exception.dart';
export 'utils/failure.dart';
export 'utils/utils.dart';
export 'utils/routes.dart';
export 'utils/http_ssl.dart';

//styles
export 'styles/colors.dart';
export 'styles/text_styles.dart';

//data
//datasources
export 'data/datasources/db/database_helper.dart';
export 'data/datasources/movie_local_data_source.dart';
export 'data/datasources/movie_remote_data_source.dart';
export 'data/datasources/tv_local_data_source.dart';
export 'data/datasources/tv_remote_data_source.dart';
//repositories
export 'data/repositories/movie_repository_impl.dart';
export 'data/repositories/tv_repository_implementations.dart';

//domain
//repositories
export 'domain/repositories/movie_repository.dart';
export 'domain/repositories/tv_repository.dart';
