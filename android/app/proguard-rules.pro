# Flutter specific
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Keep our application class
-keep class com.medaanalmaarifa.app.** { *; }

# Supabase
-keep class com.supabase.** { *; }

# Keep model classes (update with your actual model package)
-keep class com.medaanalmaarifa.app.data.models.** { *; }

# For enum classes
-keepclassmembers enum * { 
    public static **[] values(); 
    public static ** valueOf(java.lang.String); 
}

# For Parcelable classes
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Remove logging in release
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

# Keep Gson annotations
-keepattributes *Annotation*
-keepattributes Signature