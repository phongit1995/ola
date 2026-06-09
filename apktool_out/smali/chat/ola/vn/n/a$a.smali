.class Lchat/ola/vn/n/a$a;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/location/LocationListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/n/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/n/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/n/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onLocationChanged(Landroid/location/Location;)V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    invoke-static {v0}, Lchat/ola/vn/n/a;->d(Lchat/ola/vn/n/a;)Landroid/location/LocationManager;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/location/LocationManager;->removeUpdates(Landroid/location/LocationListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    invoke-static {v0}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    invoke-static {v0}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/n/b;->a(Landroid/location/Location;Landroid/location/Location;)Z

    move-result v0

    if-eqz v0, :cond_1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    invoke-static {v0, p1}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;Landroid/location/Location;)Landroid/location/Location;

    :cond_1
    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    invoke-static {v0, p1}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;Landroid/location/Location;)Landroid/location/Location;

    iget-object p1, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    invoke-static {p1}, Lchat/ola/vn/n/a;->c(Lchat/ola/vn/n/a;)V

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    invoke-static {v0}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object v0

    invoke-virtual {p1, v0}, Lchat/ola/vn/n/c;->a(Landroid/location/Location;)V

    iget-object p1, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    iget-object p1, p1, Lchat/ola/vn/n/a;->b:Lchat/ola/vn/n/b$b;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    iget-object v0, p1, Lchat/ola/vn/n/a;->b:Lchat/ola/vn/n/b$b;

    iget-object p1, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    invoke-static {p1}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object p1

    invoke-virtual {p1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v1

    iget-object p1, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    invoke-static {p1}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object p1

    invoke-virtual {p1}, Landroid/location/Location;->getLatitude()D

    move-result-wide v3

    iget-object p1, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    invoke-static {p1}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object p1

    invoke-virtual {p1}, Landroid/location/Location;->getAccuracy()F

    move-result v5

    invoke-interface/range {v0 .. v5}, Lchat/ola/vn/n/b$b;->a(DDF)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    invoke-static {v1}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object v1

    invoke-virtual {v1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/n/a$a;->a:Lchat/ola/vn/n/a;

    invoke-static {v2}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object v2

    invoke-virtual {v2}, Landroid/location/Location;->getLatitude()D

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_2
    return-void
.end method

.method public onProviderDisabled(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public onProviderEnabled(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public onStatusChanged(Ljava/lang/String;ILandroid/os/Bundle;)V
    .locals 0

    return-void
.end method
