.class Lchat/ola/vn/me/a$3;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/a;->c()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/entry/c/e;

.field final synthetic d:Lchat/ola/vn/me/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/a;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entry/c/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/a$3;->d:Lchat/ola/vn/me/a;

    iput-object p2, p0, Lchat/ola/vn/me/a$3;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/me/a$3;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/me/a$3;->c:Lchat/ola/vn/entry/c/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/OlaCheckInItemEntity;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/o;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/entity/y;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/util/List;J)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/g;",
            ">;J)V"
        }
    .end annotation

    return-void
.end method

.method public a(SLjava/lang/String;)V
    .locals 8

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p1, p0, Lchat/ola/vn/me/a$3;->d:Lchat/ola/vn/me/a;

    iget-object v1, p1, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/me/a$3;->a:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/me/a$3;->d:Lchat/ola/vn/me/a;

    iget-short v4, p1, Lchat/ola/vn/me/a;->j:S

    iget-object v5, p0, Lchat/ola/vn/me/a$3;->b:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/me/a$3;->c:Lchat/ola/vn/entry/c/e;

    invoke-static {p1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v7

    const/4 v3, 0x0

    const/4 v6, 0x0

    invoke-virtual/range {v0 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SSLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method

.method public b(Lchat/ola/vn/entity/OlaVenueEntity;)V
    .locals 0

    return-void
.end method

.method public b(Ljava/util/List;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaVenueEntity;",
            ">;I)V"
        }
    .end annotation

    return-void
.end method

.method public c(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInActionEntity;",
            ">;)V"
        }
    .end annotation

    return-void
.end method

.method public c(Ljava/util/List;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/OlaCheckInItemEntity;",
            ">;I)V"
        }
    .end annotation

    return-void
.end method

.method public f(Ljava/lang/String;)V
    .locals 8

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/me/a$3;->d:Lchat/ola/vn/me/a;

    iget-object v1, v1, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/me/a$3;->a:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/me/a$3;->d:Lchat/ola/vn/me/a;

    iget-short v4, v3, Lchat/ola/vn/me/a;->j:S

    iget-object v5, p0, Lchat/ola/vn/me/a$3;->b:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/me/a$3;->c:Lchat/ola/vn/entry/c/e;

    invoke-static {v3}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v7

    const/4 v3, 0x0

    move-object v6, p1

    invoke-virtual/range {v0 .. v7}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SSLjava/lang/String;Ljava/lang/String;S)V

    return-void
.end method
