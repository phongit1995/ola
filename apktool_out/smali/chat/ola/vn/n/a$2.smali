.class Lchat/ola/vn/n/a$2;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/n/a;->b()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/network/OlaNetworkService;

.field final synthetic b:Lchat/ola/vn/n/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/n/a;Lchat/ola/vn/network/OlaNetworkService;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/n/a$2;->b:Lchat/ola/vn/n/a;

    iput-object p2, p0, Lchat/ola/vn/n/a$2;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x1f

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/n/a$2;->a:Lchat/ola/vn/network/OlaNetworkService;

    const/4 p2, 0x0

    invoke-virtual {p1, p2, p2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 4

    const/4 v0, 0x0

    :try_start_0
    aget-object v0, p1, v0

    check-cast v0, Ljava/lang/String;

    const/4 v1, 0x1

    aget-object p1, p1, v1

    check-cast p1, Ljava/lang/String;

    new-instance v1, Landroid/location/Location;

    const-string v2, "network"

    invoke-direct {v1, v2}, Landroid/location/Location;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Landroid/location/Location;->setLongitude(D)V

    invoke-static {p1}, Ljava/lang/Double;->parseDouble(Ljava/lang/String;)D

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Landroid/location/Location;->setLatitude(D)V

    const p1, 0x453b8000    # 3000.0f

    invoke-virtual {v1, p1}, Landroid/location/Location;->setAccuracy(F)V

    iget-object p1, p0, Lchat/ola/vn/n/a$2;->b:Lchat/ola/vn/n/a;

    invoke-static {p1}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/n/a$2;->b:Lchat/ola/vn/n/a;

    invoke-static {p1}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object p1

    invoke-static {v1, p1}, Lchat/ola/vn/n/b;->a(Landroid/location/Location;Landroid/location/Location;)Z

    move-result p1

    if-eqz p1, :cond_1

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/n/a$2;->b:Lchat/ola/vn/n/a;

    invoke-static {p1, v1}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;Landroid/location/Location;)Landroid/location/Location;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
