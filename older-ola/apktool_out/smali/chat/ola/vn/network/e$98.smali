.class Lchat/ola/vn/network/e$98;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:Ljava/lang/String;

.field final synthetic f:Ljava/lang/String;

.field final synthetic g:Ljava/lang/String;

.field final synthetic h:S

.field final synthetic i:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$98;->i:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$98;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/e$98;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/network/e$98;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/network/e$98;->d:Ljava/lang/String;

    iput-object p6, p0, Lchat/ola/vn/network/e$98;->e:Ljava/lang/String;

    iput-object p7, p0, Lchat/ola/vn/network/e$98;->f:Ljava/lang/String;

    iput-object p8, p0, Lchat/ola/vn/network/e$98;->g:Ljava/lang/String;

    iput-short p9, p0, Lchat/ola/vn/network/e$98;->h:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 11

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/e$98;->i:Lchat/ola/vn/network/e;

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

    move-object v2, v1

    check-cast v2, Lchat/ola/vn/network/f;

    iget-object v3, p0, Lchat/ola/vn/network/e$98;->a:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/network/e$98;->b:Ljava/lang/String;

    iget-object v5, p0, Lchat/ola/vn/network/e$98;->c:Ljava/lang/String;

    iget-object v6, p0, Lchat/ola/vn/network/e$98;->d:Ljava/lang/String;

    iget-object v7, p0, Lchat/ola/vn/network/e$98;->e:Ljava/lang/String;

    iget-object v8, p0, Lchat/ola/vn/network/e$98;->f:Ljava/lang/String;

    iget-object v9, p0, Lchat/ola/vn/network/e$98;->g:Ljava/lang/String;

    iget-short v10, p0, Lchat/ola/vn/network/e$98;->h:S

    invoke-interface/range {v2 .. v10}, Lchat/ola/vn/network/f;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;S)V

    goto :goto_0

    :cond_0
    iget-short v0, p0, Lchat/ola/vn/network/e$98;->h:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_1

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/network/e$98;->e:Ljava/lang/String;

    aput-object v3, v1, v2

    const/4 v2, 0x1

    iget-object v3, p0, Lchat/ola/vn/network/e$98;->f:Ljava/lang/String;

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
