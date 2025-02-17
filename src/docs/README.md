# バックエンド
cd backend
npm install

# フロントエンド
cd frontend
flutter pub get

# PostgreSQLデータベースの作成
psql -U postgres
CREATE DATABASE fieldmaster;

# マイグレーションの実行
npm run migrate

# バックエンド
npm run dev

# フロントエンド
flutter run;