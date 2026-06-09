.class Lchat/ola/vn/network/e$118;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
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

.field final synthetic g:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$118;->g:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$118;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/e$118;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/network/e$118;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/network/e$118;->d:Ljava/lang/String;

    iput-object p6, p0, Lchat/ola/vn/network/e$118;->e:Ljava/lang/String;

    iput-object p7, p0, Lchat/ola/vn/network/e$118;->f:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$118;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->e(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    const/4 v3, 0x2

    if-nez v0, :cond_0

    new-instance v0, Lchat/ola/vn/message/f;

    iget-object v4, p0, Lchat/ola/vn/network/e$118;->a:Ljava/lang/String;

    invoke-direct {v0, v4, v3}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    iget-object v4, p0, Lchat/ola/vn/network/e$118;->b:Ljava/lang/String;

    invoke-virtual {v0, v4}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;)V

    iget-object v4, p0, Lchat/ola/vn/network/e$118;->c:Ljava/lang/String;

    invoke-virtual {v0, v4}, Lchat/ola/vn/message/f;->e(Ljava/lang/String;)V

    iget-object v4, p0, Lchat/ola/vn/network/e$118;->d:Ljava/lang/String;

    invoke-virtual {v0, v4}, Lchat/ola/vn/message/f;->g(Ljava/lang/String;)V

    sget-object v4, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v4, v0}, Lchat/ola/vn/message/g;->k(Lchat/ola/vn/message/f;)V

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v4, p0, Lchat/ola/vn/network/e$118;->a:Ljava/lang/String;

    invoke-virtual {v0, v4, v3, v2}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v0

    iput-boolean v1, v0, Lchat/ola/vn/message/f;->B:Z

    :cond_0
    const/16 v0, 0x14

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_1

    const/4 v4, 0x5

    new-array v4, v4, [Ljava/lang/Object;

    iget-object v5, p0, Lchat/ola/vn/network/e$118;->e:Ljava/lang/String;

    aput-object v5, v4, v1

    iget-object v1, p0, Lchat/ola/vn/network/e$118;->a:Ljava/lang/String;

    aput-object v1, v4, v2

    iget-object v1, p0, Lchat/ola/vn/network/e$118;->d:Ljava/lang/String;

    aput-object v1, v4, v3

    const/4 v1, 0x3

    iget-object v2, p0, Lchat/ola/vn/network/e$118;->b:Ljava/lang/String;

    aput-object v2, v4, v1

    const/4 v1, 0x4

    iget-object v2, p0, Lchat/ola/vn/network/e$118;->c:Ljava/lang/String;

    aput-object v2, v4, v1

    invoke-virtual {v0, v4}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/network/e$118;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    move-object v2, v1

    check-cast v2, Lchat/ola/vn/network/f;

    iget-object v3, p0, Lchat/ola/vn/network/e$118;->f:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/network/e$118;->e:Ljava/lang/String;

    iget-object v5, p0, Lchat/ola/vn/network/e$118;->a:Ljava/lang/String;

    iget-object v6, p0, Lchat/ola/vn/network/e$118;->d:Ljava/lang/String;

    iget-object v7, p0, Lchat/ola/vn/network/e$118;->b:Ljava/lang/String;

    iget-object v8, p0, Lchat/ola/vn/network/e$118;->c:Ljava/lang/String;

    invoke-interface/range {v2 .. v8}, Lchat/ola/vn/network/f;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_2
    return-void
.end method
