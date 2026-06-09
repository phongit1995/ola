.class public Lchat/ola/vn/n/c;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/network/a/a/l$a;


# static fields
.field private static c:Lchat/ola/vn/n/c;


# instance fields
.field private a:Lchat/ola/vn/entity/OlaVenueEntity;

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;"
        }
    .end annotation
.end field

.field private d:J

.field private e:Landroid/location/Location;


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/n/c;->a:Lchat/ola/vn/entity/OlaVenueEntity;

    iput-object v0, p0, Lchat/ola/vn/n/c;->b:Ljava/util/List;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/n/c;->d:J

    return-void
.end method

.method public static a()Lchat/ola/vn/n/c;
    .locals 1

    sget-object v0, Lchat/ola/vn/n/c;->c:Lchat/ola/vn/n/c;

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/n/c;

    invoke-direct {v0}, Lchat/ola/vn/n/c;-><init>()V

    sput-object v0, Lchat/ola/vn/n/c;->c:Lchat/ola/vn/n/c;

    :cond_0
    sget-object v0, Lchat/ola/vn/n/c;->c:Lchat/ola/vn/n/c;

    return-object v0
.end method


# virtual methods
.method public a(ILjava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Landroid/location/Location;)V
    .locals 2

    iput-object p1, p0, Lchat/ola/vn/n/c;->e:Landroid/location/Location;

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/n/c;->e:Landroid/location/Location;

    if-eqz v0, :cond_0

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/n/c;->d:J

    invoke-virtual {p1}, Landroid/location/Location;->getAccuracy()F

    move-result p1

    const/high16 v0, 0x42480000    # 50.0f

    cmpg-float p1, p1, v0

    if-gtz p1, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {p1, p0}, Lchat/ola/vn/network/OlaNetworkService;->a(Lchat/ola/vn/network/a/a/l$a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/n/c;->a:Lchat/ola/vn/entity/OlaVenueEntity;

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 4

    if-nez p1, :cond_0

    return-void

    :cond_0
    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/n/c;->b:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0x14

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/n/c;->b:Ljava/util/List;

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/n/c;->a:Lchat/ola/vn/entity/OlaVenueEntity;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/n/c;->a:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v0}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/n/c;->a:Lchat/ola/vn/entity/OlaVenueEntity;

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/n/c;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_3
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v2

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lchat/ola/vn/entity/OlaVenueEntity;->b(J)V

    return-void

    :cond_4
    new-instance v0, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-direct {v0}, Lchat/ola/vn/entity/OlaVenueEntity;-><init>()V

    invoke-virtual {v0, p1}, Lchat/ola/vn/entity/OlaVenueEntity;->a(Ljava/lang/String;)V

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/entity/OlaVenueEntity;->b(J)V

    iget-object p1, p0, Lchat/ola/vn/n/c;->b:Ljava/util/List;

    invoke-interface {p1, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/n/c;->b:Ljava/util/List;

    invoke-virtual {p1, v0}, Lchat/ola/vn/e;->d(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/util/List;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;)V"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/OlaVenueEntity;

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    iput-object p1, p0, Lchat/ola/vn/n/c;->a:Lchat/ola/vn/entity/OlaVenueEntity;

    iget-object p1, p0, Lchat/ola/vn/n/c;->a:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaVenueEntity;->f()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/n/c;->a:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaVenueEntity;->c()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    :cond_0
    iput-object v0, p0, Lchat/ola/vn/n/c;->a:Lchat/ola/vn/entity/OlaVenueEntity;

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/n/c;->a:Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {p0, p1}, Lchat/ola/vn/n/c;->b(Lchat/ola/vn/entity/OlaVenueEntity;)Z

    move-result p1

    if-eqz p1, :cond_2

    iput-object v0, p0, Lchat/ola/vn/n/c;->a:Lchat/ola/vn/entity/OlaVenueEntity;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method

.method public a(J)[Ljava/lang/String;
    .locals 7

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_0

    return-object v0

    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    iget-wide v3, p0, Lchat/ola/vn/n/c;->d:J

    const/4 v5, 0x0

    sub-long v5, v1, v3

    cmp-long v1, v5, p1

    if-gtz v1, :cond_1

    const/4 p1, 0x2

    new-array p1, p1, [Ljava/lang/String;

    const/4 p2, 0x0

    invoke-virtual {p0}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v1

    aput-object v1, p1, p2

    const/4 p2, 0x1

    invoke-virtual {p0}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v1

    aput-object v1, p1, p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_1
    return-object v0
.end method

.method public b()Ljava/lang/String;
    .locals 3

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/n/c;->e:Landroid/location/Location;

    invoke-virtual {v1}, Landroid/location/Location;->getLongitude()D

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public b(Lchat/ola/vn/entity/OlaVenueEntity;)Z
    .locals 8

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/n/c;->b:Ljava/util/List;

    if-nez v0, :cond_0

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/e;->y()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/n/c;->b:Ljava/util/List;

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/n/c;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/OlaVenueEntity;

    invoke-virtual {p1}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-virtual {v1}, Lchat/ola/vn/entity/OlaVenueEntity;->k()J

    move-result-wide v4
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v1, 0x0

    sub-long v6, v2, v4

    const-wide/32 v1, 0x1b77400

    cmp-long v3, v6, v1

    if-gtz v3, :cond_1

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_2
    const/4 p1, 0x0

    return p1
.end method

.method public c()Ljava/lang/String;
    .locals 3

    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/n/c;->e:Landroid/location/Location;

    invoke-virtual {v1}, Landroid/location/Location;->getLatitude()D

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(D)Ljava/lang/StringBuilder;

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public d()[Ljava/lang/String;
    .locals 2

    const-wide/32 v0, 0xdbba0

    invoke-virtual {p0, v0, v1}, Lchat/ola/vn/n/c;->a(J)[Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public e()Landroid/location/Location;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/n/c;->e:Landroid/location/Location;

    return-object v0
.end method

.method public f()Lchat/ola/vn/entity/OlaVenueEntity;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/n/c;->a:Lchat/ola/vn/entity/OlaVenueEntity;

    return-object v0
.end method
