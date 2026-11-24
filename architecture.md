lib/
  core/
    network/
      api_constants.dart           (NEW — base URL + endpoint paths)
      dio_client.dart               (NEW — configured Dio instance)
    storage/
      auth_box.dart                 (CHANGED — added tokenKey)
      users_box.dart                (now UNUSED — see note below)
    utils/
      password_hasher.dart          (now UNUSED — see note below)
  features/
    auth/
      domain/
        auth_repository.dart        (unchanged — contract didn't need to change)
        auth_failure.dart           (unchanged)
      data/
        datasources/
          auth_remote_data_source.dart       (NEW — abstract contract for the API calls)
          auth_remote_data_source_impl.dart  (NEW — Dio implementation + error mapping)
        auth_repository_impl.dart   (CHANGED — delegates to remote data source instead of usersBox)
      presentation/                 (unchanged — bloc/pages don't know or care how auth happens)
  main.dart                          (CHANGED — wires Dio + data source in)


  Two quirks of this API worth knowing before you test:

Login succeeds for eve.holt@reqres.in with any password. Any other email returns a 400.
Register succeeds only for eve.holt@reqres.in with password pistol specifically. Other combinations return 400 ("Note: Only defined users succeed the authentication").


process-assistant/
├── .env.example ✔        .gitignore ✔        pyproject.toml ✔
├── README.md ✔           docs/architecture.md ✔
├── data/sample_docs/                         (Phase 2: invented documents)
├── src/process_assistant/
│   ├── __init__.py ✔  __main__.py ✔  cli.py ✔  config.py ✔
│   ├── errors.py ✔  logging_config.py ✔
│   ├── providers/
│   │   ├── base.py ✔  retry.py ✔  gemini_chat.py ✔  factory.py ✔
│   │   └── gemini_embeddings.py              (Phase 2)
│   ├── ingestion/    (Phase 2: loaders, chunker)
│   ├── storage/      (Phase 2: SQLite)
│   ├── retrieval/    (Phase 3: search, prompt, citations)
│   ├── evaluation/   (Phase 4)
│   └── api/          (Phase 6)
├── eval/questions.json                       (Phase 4)
└── tests/ ✔ (test_config, test_retry, test_gemini_chat)