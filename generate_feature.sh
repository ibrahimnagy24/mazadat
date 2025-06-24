#!/bin/bash

# Script to generate a new Flutter feature with PascalCase class names and lowercase file names

generate_feature() {
    local feature_name=$1
    local feature_dir="lib/features/$feature_name"
    local app="../../../core"

    # Convert feature name to PascalCase for class names
    # shellcheck disable=SC2155
    local class_name=$(echo "$feature_name" | awk -F'_' '{for (i=1; i<=NF; i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1' OFS='')

    # Convert feature name to camelCase for method names
    # shellcheck disable=SC2155
    local method_name=$(echo "$feature_name" | awk -F'_' '{for (i=1; i<=NF; i++) $i=tolower($i)}1' OFS='' | sed -E 's/^(.)/\1/')

    # Convert feature name to lowercase for file names
    # shellcheck disable=SC2155
    local file_name=$(echo "$feature_name" | tr '[:upper:]' '[:lower:]')

    # Create directories
    mkdir -p "$feature_dir/bloc"
    mkdir -p "$feature_dir/repository"
    mkdir -p "$feature_dir/model"
    mkdir -p "$feature_dir/page"
    mkdir -p "$feature_dir/widgets" # New widgets folder

    # Create Bloc file
    cat > "$feature_dir/bloc/${file_name}_bloc.dart" <<EOF
import 'package:flutter_bloc/flutter_bloc.dart';
import '${app}/app_event.dart';
import '${app}/app_state.dart';
import '../../../navigation/custom_navigation.dart';

class ${class_name}Bloc extends Bloc<AppEvent, AppState> {
  ${class_name}Bloc() : super(Start()) {
    on<Click>(onClick);
  }

  static ${class_name}Bloc get instance => BlocProvider.of(CustomNavigator.context);

  Future<void> onClick(AppEvent event, Emitter<AppState> emit) async {
    ///
  }
}
EOF

    # Create Repository file with a camelCase method
    cat > "$feature_dir/repository/${file_name}_repository.dart" <<EOF
import 'core/app_config/api_names.dart';
import 'core/network/network_helper.dart';

abstract class ${class_name}Repository {
  static Future<dynamic> ${method_name}Method() async {
    return await Network().request(
      'EndPoint',
      method: ServerMethods.GET,
    );
  }
}
EOF

    # Create Default Screen
    cat > "$feature_dir/page/${file_name}_screen.dart" <<EOF
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/${file_name}_bloc.dart';
import '${app}/app_event.dart';
import '${app}/app_state.dart';

class ${class_name}Screen extends StatelessWidget {
  const ${class_name}Screen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ${class_name}Bloc(),
      child: BlocBuilder<${class_name}Bloc, AppState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('${class_name} Screen'),
            ),
            body: const Center(child: Text('Trigger Event')),
          );
        },
      ),
    );
  }
}
EOF

    # Create Model file
    cat > "$feature_dir/model/${file_name}_model.dart" <<EOF
class ${class_name}Model {
  final String id;
  final String name;

  ${class_name}Model({required this.id, required this.name});

  factory ${class_name}Model.fromJson(Map<String, dynamic> json) {
    return ${class_name}Model(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
EOF

    # Create Widgets file
    cat > "$feature_dir/widgets/${file_name}_widgets.dart" <<EOF
import 'package:flutter/material.dart';

class ${class_name}Widget extends StatelessWidget {
  const ${class_name}Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(
        '${class_name}Widget',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
EOF

    echo "Feature $feature_name generated successfully in $feature_dir!"
}

# Check if feature name is provided
if [ -z "$1" ]; then
    echo "Usage: ./generate_feature.sh <feature_name>"
    exit 1
fi

# Call the function
generate_feature "$1"
