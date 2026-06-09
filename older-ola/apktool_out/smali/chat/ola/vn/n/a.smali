.class Lchat/ola/vn/n/a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/n/a$a;
    }
.end annotation


# instance fields
.field protected a:Landroid/content/Context;

.field protected b:Lchat/ola/vn/n/b$b;

.field protected c:J

.field protected d:Z

.field private e:Lchat/ola/vn/n/a$a;

.field private f:Lchat/ola/vn/n/a$a;

.field private g:Lchat/ola/vn/n/a$a;

.field private h:Landroid/location/Location;

.field private i:Landroid/location/LocationManager;

.field private j:Ljava/lang/Runnable;

.field private k:Z

.field private l:J


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/n/a;->h:Landroid/location/Location;

    iput-object v0, p0, Lchat/ola/vn/n/a;->j:Ljava/lang/Runnable;

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/n/a;->k:Z

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/n/a;->l:J

    iput-object p1, p0, Lchat/ola/vn/n/a;->a:Landroid/content/Context;

    const-string v0, "location"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/location/LocationManager;

    iput-object p1, p0, Lchat/ola/vn/n/a;->i:Landroid/location/LocationManager;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/n/a;)Landroid/location/Location;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/n/a;->h:Landroid/location/Location;

    return-object p0
.end method

.method static synthetic a(Lchat/ola/vn/n/a;Landroid/location/Location;)Landroid/location/Location;
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/n/a;->h:Landroid/location/Location;

    return-object p1
.end method

.method private a()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/n/a;->j:Ljava/lang/Runnable;

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->c(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/n/a;->i:Landroid/location/LocationManager;

    iget-object v1, p0, Lchat/ola/vn/n/a;->e:Lchat/ola/vn/n/a$a;

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/n/a;->i:Landroid/location/LocationManager;

    iget-object v1, p0, Lchat/ola/vn/n/a;->f:Lchat/ola/vn/n/a$a;

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :catch_2
    :try_start_3
    iget-object v0, p0, Lchat/ola/vn/n/a;->i:Landroid/location/LocationManager;

    iget-object v1, p0, Lchat/ola/vn/n/a;->g:Lchat/ola/vn/n/a$a;

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :catch_3
    return-void
.end method

.method private b()V
    .locals 10

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/n/a;->a:Landroid/content/Context;

    const-string v1, "phone"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getNetworkOperator()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    return-void

    :cond_0
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getPhoneType()I

    move-result v2

    const/4 v3, 0x2

    if-ne v2, v3, :cond_1

    return-void

    :cond_1
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getCellLocation()Landroid/telephony/CellLocation;

    move-result-object v0

    check-cast v0, Landroid/telephony/gsm/GsmCellLocation;

    const/4 v2, 0x0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Landroid/telephony/gsm/GsmCellLocation;->getCid()I

    move-result v3

    invoke-virtual {v0}, Landroid/telephony/gsm/GsmCellLocation;->getLac()I

    move-result v0

    goto :goto_0

    :cond_2
    const/4 v0, 0x0

    const/4 v3, 0x0

    :goto_0
    const/4 v4, 0x3

    invoke-virtual {v1, v2, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    invoke-static {v3}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v5

    invoke-static {v0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v2}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v7

    invoke-static {v1}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v8

    sget-object v4, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v4, :cond_3

    new-instance v0, Lchat/ola/vn/n/a$2;

    invoke-direct {v0, p0, v4}, Lchat/ola/vn/n/a$2;-><init>(Lchat/ola/vn/n/a;Lchat/ola/vn/network/OlaNetworkService;)V

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v9

    invoke-virtual/range {v4 .. v9}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_3
    return-void
.end method

.method static synthetic b(Lchat/ola/vn/n/a;)Z
    .locals 0

    iget-boolean p0, p0, Lchat/ola/vn/n/a;->k:Z

    return p0
.end method

.method static synthetic c(Lchat/ola/vn/n/a;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/n/a;->a()V

    return-void
.end method

.method static synthetic d(Lchat/ola/vn/n/a;)Landroid/location/LocationManager;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/n/a;->i:Landroid/location/LocationManager;

    return-object p0
.end method


# virtual methods
.method public a(JZ)V
    .locals 8

    :try_start_0
    new-instance v0, Lchat/ola/vn/n/a$a;

    invoke-direct {v0, p0}, Lchat/ola/vn/n/a$a;-><init>(Lchat/ola/vn/n/a;)V

    iput-object v0, p0, Lchat/ola/vn/n/a;->e:Lchat/ola/vn/n/a$a;

    iget-object v0, p0, Lchat/ola/vn/n/a;->h:Landroid/location/Location;

    if-eqz v0, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget-wide v2, p0, Lchat/ola/vn/n/a;->l:J

    const/4 v4, 0x0

    sub-long v4, v0, v2

    const-wide/32 v0, 0x493e0

    cmp-long v2, v4, v0

    if-gtz v2, :cond_1

    iget-object v0, p0, Lchat/ola/vn/n/a;->b:Lchat/ola/vn/n/b$b;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/n/a;->b:Lchat/ola/vn/n/b$b;

    iget-object v0, p0, Lchat/ola/vn/n/a;->h:Landroid/location/Location;

    invoke-virtual {v0}, Landroid/location/Location;->getLongitude()D

    move-result-wide v2

    iget-object v0, p0, Lchat/ola/vn/n/a;->h:Landroid/location/Location;

    invoke-virtual {v0}, Landroid/location/Location;->getLatitude()D

    move-result-wide v4

    iget-object v0, p0, Lchat/ola/vn/n/a;->h:Landroid/location/Location;

    invoke-virtual {v0}, Landroid/location/Location;->getAccuracy()F

    move-result v6

    invoke-interface/range {v1 .. v6}, Lchat/ola/vn/n/b$b;->a(DDF)V

    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/n/a;->b:Lchat/ola/vn/n/b$b;

    :cond_1
    const-wide/16 v0, 0x0

    cmp-long v2, p1, v0

    if-gtz v2, :cond_2

    const-wide/16 p1, 0x7530

    :cond_2
    iput-boolean p3, p0, Lchat/ola/vn/n/a;->d:Z

    iput-wide p1, p0, Lchat/ola/vn/n/a;->c:J

    iget-object p1, p0, Lchat/ola/vn/n/a;->i:Landroid/location/LocationManager;

    const-string p2, "gps"

    invoke-virtual {p1, p2}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result p1

    iput-boolean p1, p0, Lchat/ola/vn/n/a;->k:Z

    iget-boolean p1, p0, Lchat/ola/vn/n/a;->k:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez p1, :cond_4

    const/16 p1, 0x1f

    :try_start_1
    invoke-static {p1}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    iget-object p1, p0, Lchat/ola/vn/n/a;->b:Lchat/ola/vn/n/b$b;

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/n/a;->b:Lchat/ola/vn/n/b$b;

    invoke-interface {p1}, Lchat/ola/vn/n/b$b;->l_()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_3
    return-void

    :cond_4
    :try_start_2
    iget-object p1, p0, Lchat/ola/vn/n/a;->b:Lchat/ola/vn/n/b$b;

    if-eqz p1, :cond_5

    iget-object p1, p0, Lchat/ola/vn/n/a;->b:Lchat/ola/vn/n/b$b;

    invoke-interface {p1}, Lchat/ola/vn/n/b$b;->k_()V

    :cond_5
    iget-object p1, p0, Lchat/ola/vn/n/a;->i:Landroid/location/LocationManager;

    const-string p2, "gps"

    invoke-virtual {p1, p2}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object p1

    if-nez p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/n/a;->i:Landroid/location/LocationManager;

    const-string p2, "network"

    invoke-virtual {p1, p2}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object p1

    :cond_6
    if-eqz p1, :cond_7

    iget-object p2, p0, Lchat/ola/vn/n/a;->h:Landroid/location/Location;

    invoke-static {p1, p2}, Lchat/ola/vn/n/b;->a(Landroid/location/Location;Landroid/location/Location;)Z

    move-result p2

    if-eqz p2, :cond_7

    iput-object p1, p0, Lchat/ola/vn/n/a;->h:Landroid/location/Location;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p1

    iput-wide p1, p0, Lchat/ola/vn/n/a;->l:J

    iget-object p1, p0, Lchat/ola/vn/n/a;->e:Lchat/ola/vn/n/a$a;

    iget-object p2, p0, Lchat/ola/vn/n/a;->h:Landroid/location/Location;

    invoke-virtual {p1, p2}, Lchat/ola/vn/n/a$a;->onLocationChanged(Landroid/location/Location;)V

    return-void

    :cond_7
    iget-object v2, p0, Lchat/ola/vn/n/a;->i:Landroid/location/LocationManager;

    const-string v3, "gps"

    const-wide/32 v4, 0xea60

    const/high16 v6, 0x3f800000    # 1.0f

    iget-object v7, p0, Lchat/ola/vn/n/a;->e:Lchat/ola/vn/n/a$a;

    invoke-virtual/range {v2 .. v7}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V

    iget-object p1, p0, Lchat/ola/vn/n/a;->i:Landroid/location/LocationManager;

    const-string p2, "network"

    invoke-virtual {p1, p2}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_8

    new-instance p1, Lchat/ola/vn/n/a$a;

    invoke-direct {p1, p0}, Lchat/ola/vn/n/a$a;-><init>(Lchat/ola/vn/n/a;)V

    iput-object p1, p0, Lchat/ola/vn/n/a;->f:Lchat/ola/vn/n/a$a;

    iget-object v2, p0, Lchat/ola/vn/n/a;->i:Landroid/location/LocationManager;

    const-string v3, "network"

    const-wide/32 v4, 0xea60

    const/high16 v6, 0x3f800000    # 1.0f

    iget-object v7, p0, Lchat/ola/vn/n/a;->f:Lchat/ola/vn/n/a$a;

    invoke-virtual/range {v2 .. v7}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V

    :cond_8
    iget-object p1, p0, Lchat/ola/vn/n/a;->i:Landroid/location/LocationManager;

    const-string p2, "passive"

    invoke-virtual {p1, p2}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_9

    new-instance p1, Lchat/ola/vn/n/a$a;

    invoke-direct {p1, p0}, Lchat/ola/vn/n/a$a;-><init>(Lchat/ola/vn/n/a;)V

    iput-object p1, p0, Lchat/ola/vn/n/a;->g:Lchat/ola/vn/n/a$a;

    iget-object v2, p0, Lchat/ola/vn/n/a;->i:Landroid/location/LocationManager;

    const-string v3, "passive"

    const-wide/32 v4, 0xea60

    const/high16 v6, 0x3f800000    # 1.0f

    iget-object v7, p0, Lchat/ola/vn/n/a;->g:Lchat/ola/vn/n/a$a;

    invoke-virtual/range {v2 .. v7}, Landroid/location/LocationManager;->requestLocationUpdates(Ljava/lang/String;JFLandroid/location/LocationListener;)V

    :cond_9
    iget-object p1, p0, Lchat/ola/vn/n/a;->a:Landroid/content/Context;

    invoke-static {p1}, Lchat/ola/vn/util/n;->b(Landroid/content/Context;)Z

    move-result p1

    if-eqz p1, :cond_a

    invoke-direct {p0}, Lchat/ola/vn/n/a;->b()V

    :cond_a
    iget-wide p1, p0, Lchat/ola/vn/n/a;->c:J

    cmp-long p3, p1, v0

    if-lez p3, :cond_b

    new-instance p1, Lchat/ola/vn/n/a$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/n/a$1;-><init>(Lchat/ola/vn/n/a;)V

    iput-object p1, p0, Lchat/ola/vn/n/a;->j:Ljava/lang/Runnable;

    iget-object p1, p0, Lchat/ola/vn/n/a;->j:Ljava/lang/Runnable;

    iget-wide p2, p0, Lchat/ola/vn/n/a;->c:J

    invoke-static {p1, p2, p3}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_b
    return-void
.end method

.method public a(Lchat/ola/vn/n/b$b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/n/a;->b:Lchat/ola/vn/n/b$b;

    return-void
.end method
