.class Lchat/ola/vn/network/e$62;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Lchat/ola/vn/entity/b;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/b;

.field final synthetic b:S

.field final synthetic c:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Lchat/ola/vn/entity/b;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$62;->c:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$62;->a:Lchat/ola/vn/entity/b;

    iput-short p3, p0, Lchat/ola/vn/network/e$62;->b:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/e$62;->c:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    iget-object v2, p0, Lchat/ola/vn/network/e$62;->a:Lchat/ola/vn/entity/b;

    iget-short v3, p0, Lchat/ola/vn/network/e$62;->b:S

    invoke-interface {v1, v2, v3}, Lchat/ola/vn/network/f;->a(Lchat/ola/vn/entity/b;S)V

    goto :goto_0

    :cond_0
    iget-short v0, p0, Lchat/ola/vn/network/e$62;->b:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_1

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/network/e$62;->a:Lchat/ola/vn/entity/b;

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
