.class public Lchat/ola/vn/service/AppReceiver;
.super Landroid/content/BroadcastReceiver;

# interfaces
.implements Lchat/ola/vn/f/a;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2

    if-eqz p2, :cond_5

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object p2

    if-eqz p2, :cond_5

    const-string v0, "android.intent.action.BOOT_COMPLETED"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    new-instance p2, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/network/OlaNetworkService;

    invoke-direct {p2, p1, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v0, "Source"

    const-class v1, Lchat/ola/vn/service/AppReceiver;

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p2, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {p1, p2}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    new-instance p2, Landroid/content/Intent;

    const-class v0, Lchat/ola/vn/balloon/OlaBalloonService;

    invoke-direct {p2, p1, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p1, p2}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    return-void

    :cond_0
    const-string v0, "android.net.conn.CONNECTIVITY_CHANGE"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "android.net.wifi.STATE_CHANGE"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, "android.net.wifi.WIFI_STATE_CHANGED"

    invoke-virtual {p2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_5

    :cond_1
    invoke-static {p1}, Lchat/ola/vn/util/n;->c(Landroid/content/Context;)Z

    move-result p2

    const/4 v0, 0x0

    if-eqz p2, :cond_4

    const/4 p2, 0x1

    sput-boolean p2, Lchat/ola/vn/h;->F:Z

    sput-boolean v0, Lchat/ola/vn/h;->I:Z

    const-string v1, "connectivity"

    invoke-virtual {p1, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/net/ConnectivityManager;

    if-eqz v1, :cond_2

    invoke-virtual {v1}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-virtual {v1}, Landroid/net/NetworkInfo;->getType()I

    move-result v1

    if-ne v1, p2, :cond_2

    sput-boolean p2, Lchat/ola/vn/h;->I:Z

    :cond_2
    const-string v1, "phone"

    invoke-virtual {p1, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/telephony/TelephonyManager;

    :try_start_0
    sget-boolean v1, Lchat/ola/vn/h;->I:Z

    if-nez v1, :cond_5

    sput-boolean p2, Lchat/ola/vn/h;->J:Z

    invoke-virtual {p1}, Landroid/telephony/TelephonyManager;->getNetworkType()I

    move-result v1

    if-eq v1, p2, :cond_3

    invoke-virtual {p1}, Landroid/telephony/TelephonyManager;->getNetworkType()I

    move-result p1

    const/4 p2, 0x2

    if-ne p1, p2, :cond_5

    :cond_3
    sput-boolean v0, Lchat/ola/vn/h;->J:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_4
    sput-boolean v0, Lchat/ola/vn/h;->F:Z

    :catch_0
    :cond_5
    return-void
.end method
