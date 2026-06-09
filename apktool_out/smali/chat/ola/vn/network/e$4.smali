.class Lchat/ola/vn/network/e$4;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;SLjava/lang/String;Ljava/util/List;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:S

.field final synthetic c:Ljava/util/List;

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:S

.field final synthetic f:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;SLjava/util/List;Ljava/lang/String;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$4;->f:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$4;->a:Ljava/lang/String;

    iput-short p3, p0, Lchat/ola/vn/network/e$4;->b:S

    iput-object p4, p0, Lchat/ola/vn/network/e$4;->c:Ljava/util/List;

    iput-object p5, p0, Lchat/ola/vn/network/e$4;->d:Ljava/lang/String;

    iput-short p6, p0, Lchat/ola/vn/network/e$4;->e:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$4;->a:Ljava/lang/String;

    iget-short v2, p0, Lchat/ola/vn/network/e$4;->b:S

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v0

    const/4 v1, 0x1

    const/4 v2, 0x2

    if-eqz v0, :cond_1

    iget-object v4, p0, Lchat/ola/vn/network/e$4;->c:Ljava/util/List;

    const/4 v5, 0x0

    if-eqz v4, :cond_0

    iget-object v4, p0, Lchat/ola/vn/network/e$4;->c:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    if-lez v4, :cond_0

    iput-byte v2, v0, Lchat/ola/vn/message/f;->V:B

    iput-object v5, v0, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    iput-boolean v1, v0, Lchat/ola/vn/message/f;->Q:Z

    iget-object v4, p0, Lchat/ola/vn/network/e$4;->c:Ljava/util/List;

    iget-object v5, p0, Lchat/ola/vn/network/e$4;->d:Ljava/lang/String;

    invoke-virtual {v0, v4, v5}, Lchat/ola/vn/message/f;->a(Ljava/util/List;Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iput-byte v2, v0, Lchat/ola/vn/message/f;->V:B

    iput-object v5, v0, Lchat/ola/vn/message/f;->O:Ljava/lang/String;

    iput-boolean v3, v0, Lchat/ola/vn/message/f;->Q:Z

    iget-object v4, p0, Lchat/ola/vn/network/e$4;->d:Ljava/lang/String;

    invoke-virtual {v0, v5, v4}, Lchat/ola/vn/message/f;->a(Ljava/util/List;Ljava/lang/String;)V

    :cond_1
    :goto_0
    iget-short v0, p0, Lchat/ola/vn/network/e$4;->e:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_2

    const/4 v4, 0x5

    new-array v4, v4, [Ljava/lang/Object;

    iget-object v5, p0, Lchat/ola/vn/network/e$4;->a:Ljava/lang/String;

    aput-object v5, v4, v3

    iget-short v3, p0, Lchat/ola/vn/network/e$4;->b:S

    invoke-static {v3}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v3

    aput-object v3, v4, v1

    iget-object v1, p0, Lchat/ola/vn/network/e$4;->d:Ljava/lang/String;

    aput-object v1, v4, v2

    const/4 v1, 0x3

    iget-object v2, p0, Lchat/ola/vn/network/e$4;->c:Ljava/util/List;

    aput-object v2, v4, v1

    const/4 v1, 0x4

    iget-short v2, p0, Lchat/ola/vn/network/e$4;->e:S

    invoke-static {v2}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v2

    aput-object v2, v4, v1

    invoke-virtual {v0, v4}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/network/e$4;->f:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    move-object v2, v1

    check-cast v2, Lchat/ola/vn/network/f;

    iget-object v3, p0, Lchat/ola/vn/network/e$4;->a:Ljava/lang/String;

    iget-short v4, p0, Lchat/ola/vn/network/e$4;->b:S

    iget-object v5, p0, Lchat/ola/vn/network/e$4;->d:Ljava/lang/String;

    iget-object v6, p0, Lchat/ola/vn/network/e$4;->c:Ljava/util/List;

    iget-short v7, p0, Lchat/ola/vn/network/e$4;->e:S

    invoke-interface/range {v2 .. v7}, Lchat/ola/vn/network/f;->a(Ljava/lang/String;SLjava/lang/String;Ljava/util/List;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    :cond_3
    return-void
.end method
