.class Lchat/ola/vn/n/a$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/n/a;->a(JZ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/n/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/n/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    invoke-static {v0}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    invoke-static {v0}, Lchat/ola/vn/n/a;->b(Lchat/ola/vn/n/a;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    iget-object v0, v0, Lchat/ola/vn/n/a;->b:Lchat/ola/vn/n/b$b;

    invoke-interface {v0}, Lchat/ola/vn/n/b$b;->j_()V

    goto/16 :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    iget-object v0, v0, Lchat/ola/vn/n/a;->b:Lchat/ola/vn/n/b$b;

    invoke-interface {v0}, Lchat/ola/vn/n/b$b;->l_()V

    goto :goto_0

    :cond_1
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    invoke-static {v1}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/n/c;->a(Landroid/location/Location;)V

    iget-object v0, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    iget-object v1, v0, Lchat/ola/vn/n/a;->b:Lchat/ola/vn/n/b$b;

    iget-object v0, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    invoke-static {v0}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object v0

    invoke-virtual {v0}, Landroid/location/Location;->getLongitude()D

    move-result-wide v2

    iget-object v0, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    invoke-static {v0}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object v0

    invoke-virtual {v0}, Landroid/location/Location;->getLatitude()D

    move-result-wide v4

    iget-object v0, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    invoke-static {v0}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object v0

    invoke-virtual {v0}, Landroid/location/Location;->getAccuracy()F

    move-result v6

    invoke-interface/range {v1 .. v6}, Lchat/ola/vn/n/b$b;->a(DDF)V

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    invoke-static {v2}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object v2

    invoke-virtual {v2}, Landroid/location/Location;->getLongitude()D

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    invoke-static {v3}, Lchat/ola/vn/n/a;->a(Lchat/ola/vn/n/a;)Landroid/location/Location;

    move-result-object v3

    invoke-virtual {v3}, Landroid/location/Location;->getLatitude()D

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v3, ""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    iget-object v1, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    invoke-static {v1}, Lchat/ola/vn/n/a;->c(Lchat/ola/vn/n/a;)V

    throw v0

    :catch_0
    :goto_0
    iget-object v0, p0, Lchat/ola/vn/n/a$1;->a:Lchat/ola/vn/n/a;

    invoke-static {v0}, Lchat/ola/vn/n/a;->c(Lchat/ola/vn/n/a;)V

    return-void
.end method
