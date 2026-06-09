.class Lchat/ola/vn/network/e$133;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:S

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Ljava/util/List;

.field final synthetic e:Ljava/lang/String;

.field final synthetic f:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;SLjava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$133;->f:Lchat/ola/vn/network/e;

    iput-short p2, p0, Lchat/ola/vn/network/e$133;->a:S

    iput-object p3, p0, Lchat/ola/vn/network/e$133;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/network/e$133;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/network/e$133;->d:Ljava/util/List;

    iput-object p6, p0, Lchat/ola/vn/network/e$133;->e:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    :try_start_0
    iget-short v0, p0, Lchat/ola/vn/network/e$133;->a:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v1, 0x5

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/network/e$133;->b:Ljava/lang/String;

    aput-object v3, v1, v2

    const/4 v2, 0x1

    iget-object v3, p0, Lchat/ola/vn/network/e$133;->c:Ljava/lang/String;

    aput-object v3, v1, v2

    const/4 v2, 0x2

    iget-object v3, p0, Lchat/ola/vn/network/e$133;->d:Ljava/util/List;

    aput-object v3, v1, v2

    const/4 v2, 0x3

    iget-object v3, p0, Lchat/ola/vn/network/e$133;->e:Ljava/lang/String;

    aput-object v3, v1, v2

    const/4 v2, 0x4

    iget-short v3, p0, Lchat/ola/vn/network/e$133;->a:S

    invoke-static {v3}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/e$133;->f:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    move-object v2, v1

    check-cast v2, Lchat/ola/vn/network/f;

    iget-object v3, p0, Lchat/ola/vn/network/e$133;->b:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/network/e$133;->c:Ljava/lang/String;

    iget-object v5, p0, Lchat/ola/vn/network/e$133;->d:Ljava/util/List;

    iget-object v6, p0, Lchat/ola/vn/network/e$133;->e:Ljava/lang/String;

    iget-short v7, p0, Lchat/ola/vn/network/e$133;->a:S

    invoke-interface/range {v2 .. v7}, Lchat/ola/vn/network/f;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_1
    return-void
.end method
