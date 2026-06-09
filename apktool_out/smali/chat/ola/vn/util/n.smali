.class public Lchat/ola/vn/util/n;
.super Ljava/lang/Object;


# direct methods
.method public static a(Landroid/content/Context;)I
    .locals 4

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "status_bar_height"

    const-string v2, "dimen"

    const-string v3, "android"

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v0

    if-lez v0, :cond_0

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0, v0}, Landroid/content/res/Resources;->getDimensionPixelOffset(I)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :cond_0
    const/16 p0, 0xf

    return p0

    :catch_0
    const/4 p0, 0x0

    return p0
.end method

.method public static a(Landroid/content/Context;Landroid/net/Uri;)Z
    .locals 2

    :try_start_0
    new-instance v0, Landroid/media/MediaPlayer;

    invoke-direct {v0}, Landroid/media/MediaPlayer;-><init>()V

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Landroid/media/MediaPlayer;->setAudioStreamType(I)V

    invoke-virtual {v0, p0, p1}, Landroid/media/MediaPlayer;->setDataSource(Landroid/content/Context;Landroid/net/Uri;)V

    const/high16 p0, 0x3f800000    # 1.0f

    invoke-virtual {v0, p0, p0}, Landroid/media/MediaPlayer;->setVolume(FF)V

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->prepare()V

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->start()V

    new-instance p0, Lchat/ola/vn/util/n$1;

    invoke-direct {p0}, Lchat/ola/vn/util/n$1;-><init>()V

    invoke-virtual {v0, p0}, Landroid/media/MediaPlayer;->setOnCompletionListener(Landroid/media/MediaPlayer$OnCompletionListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p0, 0x1

    return p0

    :catch_0
    const/4 p0, 0x0

    return p0
.end method

.method public static b(Landroid/content/Context;)Z
    .locals 2

    const/4 v0, 0x0

    :try_start_0
    const-string v1, "phone"

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/telephony/TelephonyManager;

    invoke-virtual {p0}, Landroid/telephony/TelephonyManager;->getSimState()I

    move-result p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x1

    packed-switch p0, :pswitch_data_0

    :pswitch_0
    const/4 v0, 0x1

    :catch_0
    :pswitch_1
    return v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static c(Landroid/content/Context;)Z
    .locals 2

    const-string v0, "connectivity"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/net/ConnectivityManager;

    invoke-virtual {p0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object p0

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return v0

    :cond_0
    invoke-virtual {p0}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v1

    if-nez v1, :cond_1

    return v0

    :cond_1
    invoke-virtual {p0}, Landroid/net/NetworkInfo;->isAvailable()Z

    move-result p0

    if-nez p0, :cond_2

    return v0

    :cond_2
    const/4 p0, 0x1

    return p0
.end method

.method public static d(Landroid/content/Context;)I
    .locals 1

    const-string v0, "audio"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/media/AudioManager;

    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Landroid/media/AudioManager;->getStreamVolume(I)I

    move-result p0

    return p0
.end method

.method public static e(Landroid/content/Context;)I
    .locals 1

    const-string v0, "audio"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/media/AudioManager;

    const/4 v0, 0x3

    invoke-virtual {p0, v0}, Landroid/media/AudioManager;->getStreamMaxVolume(I)I

    move-result p0

    return p0
.end method

.method public static f(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "android_id"

    invoke-static {v0, v1}, Landroid/provider/Settings$Secure;->getString(Landroid/content/ContentResolver;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "9774d56d682e549c"

    invoke-static {v1, v0}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    if-nez v1, :cond_0

    return-object v0

    :cond_0
    :try_start_1
    const-string v0, "phone"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getDeviceId()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    if-nez v1, :cond_1

    return-object v0

    :catch_0
    move-exception v0

    :try_start_2
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :cond_1
    :try_start_3
    const-string v0, "wifi"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/net/wifi/WifiManager;

    invoke-virtual {p0}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object p0

    invoke-virtual {p0}, Landroid/net/wifi/WifiInfo;->getMacAddress()Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_1

    if-nez v0, :cond_2

    return-object p0

    :catch_1
    move-exception p0

    :try_start_4
    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    goto :goto_0

    :catch_2
    move-exception p0

    invoke-virtual {p0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    :goto_0
    const-string p0, "9774d56d682e549c"

    return-object p0
.end method

.method public static g(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    :try_start_0
    invoke-static {p0}, Lchat/ola/vn/util/n;->i(Landroid/content/Context;)Landroid/database/Cursor;

    move-result-object p0

    const-string v0, ""

    :goto_0
    invoke-interface {p0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v0, "display_name"

    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :cond_0
    return-object v0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static h(Landroid/content/Context;)Ljava/lang/String;
    .locals 2

    invoke-static {p0}, Lchat/ola/vn/util/n;->i(Landroid/content/Context;)Landroid/database/Cursor;

    move-result-object p0

    const/4 v0, 0x0

    :cond_0
    invoke-interface {p0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v0, "data1"

    invoke-interface {p0, v0}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v0

    invoke-interface {p0, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    :cond_1
    return-object v0
.end method

.method static i(Landroid/content/Context;)Landroid/database/Cursor;
    .locals 10

    invoke-static {p0}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object v0

    const-string v1, "com.google"

    invoke-virtual {v0, v1}, Landroid/accounts/AccountManager;->getAccountsByType(Ljava/lang/String;)[Landroid/accounts/Account;

    move-result-object v0

    const/4 v1, 0x0

    aget-object v2, v0, v1

    iget-object v2, v2, Landroid/accounts/Account;->name:Ljava/lang/String;

    if-eqz v2, :cond_1

    aget-object v1, v0, v1

    iget-object v1, v1, Landroid/accounts/Account;->name:Ljava/lang/String;

    const-string v2, "data1 = ?"

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const/4 v1, 0x1

    move-object v7, v2

    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_0

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " or data1 = ?"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    aget-object v2, v0, v1

    iget-object v2, v2, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v0

    new-array v0, v0, [Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v0

    move-object v8, v0

    check-cast v8, [Ljava/lang/String;

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    sget-object v5, Landroid/provider/ContactsContract$CommonDataKinds$Email;->CONTENT_URI:Landroid/net/Uri;

    const/4 v6, 0x0

    const/4 v9, 0x0

    invoke-virtual/range {v4 .. v9}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object p0

    return-object p0

    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

.method public static j(Landroid/content/Context;)Ljava/lang/String;
    .locals 17

    const/4 v0, 0x0

    :try_start_0
    invoke-static/range {p0 .. p0}, Landroid/accounts/AccountManager;->get(Landroid/content/Context;)Landroid/accounts/AccountManager;

    move-result-object v1

    const-string v2, "com.google"

    invoke-virtual {v1, v2}, Landroid/accounts/AccountManager;->getAccountsByType(Ljava/lang/String;)[Landroid/accounts/Account;

    move-result-object v1

    const/4 v2, 0x0

    aget-object v3, v1, v2

    iget-object v3, v3, Landroid/accounts/Account;->name:Ljava/lang/String;

    if-eqz v3, :cond_5

    aget-object v3, v1, v2

    iget-object v3, v3, Landroid/accounts/Account;->name:Ljava/lang/String;

    const-string v4, "data1 = ?"

    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    invoke-virtual {v5, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    const/4 v3, 0x1

    move-object v9, v4

    const/4 v4, 0x1

    :goto_0
    array-length v6, v1

    if-ge v4, v6, :cond_0

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v7, " or data1 = ?"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    aget-object v6, v1, v4

    iget-object v6, v6, Landroid/accounts/Account;->name:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_0
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v1

    new-array v1, v1, [Ljava/lang/String;

    invoke-virtual {v5, v1}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    move-object v10, v1

    check-cast v10, [Ljava/lang/String;

    invoke-virtual/range {p0 .. p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    sget-object v7, Landroid/provider/ContactsContract$CommonDataKinds$Email;->CONTENT_URI:Landroid/net/Uri;

    const/4 v8, 0x0

    const/4 v11, 0x0

    move-object v6, v1

    invoke-virtual/range {v6 .. v11}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v4

    :catch_0
    :cond_1
    :goto_1
    invoke-interface {v4}, Landroid/database/Cursor;->moveToNext()Z

    move-result v5
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    if-eqz v5, :cond_5

    :try_start_1
    const-string v5, "contact_id"

    invoke-interface {v4, v5}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v5

    invoke-interface {v4, v5}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    if-eqz v5, :cond_1

    sget-object v12, Landroid/provider/ContactsContract$CommonDataKinds$Phone;->CONTENT_URI:Landroid/net/Uri;

    const/4 v13, 0x0

    const-string v14, "contact_id = ?"

    new-array v15, v3, [Ljava/lang/String;

    aput-object v5, v15, v2

    const/16 v16, 0x0

    move-object v11, v1

    invoke-virtual/range {v11 .. v16}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v5

    :goto_2
    invoke-interface {v5}, Landroid/database/Cursor;->moveToNext()Z

    move-result v6

    if-eqz v6, :cond_4

    const-string v6, "data1"

    invoke-interface {v5, v6}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v6

    invoke-interface {v5, v6}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v6
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :try_start_2
    invoke-static {v6}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_3

    invoke-static {}, Lchat/ola/vn/c;->x()Z

    move-result v0

    if-eqz v0, :cond_2

    invoke-virtual {v6}, Ljava/lang/String;->length()I

    move-result v0
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    const/16 v7, 0xa

    if-lt v0, v7, :cond_3

    :cond_2
    move-object v0, v6

    goto :goto_3

    :cond_3
    move-object v0, v6

    goto :goto_2

    :catch_1
    move-object v0, v6

    goto :goto_1

    :cond_4
    :goto_3
    :try_start_3
    invoke-interface {v5}, Landroid/database/Cursor;->close()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_0

    goto :goto_1

    :catch_2
    :cond_5
    return-object v0
.end method
