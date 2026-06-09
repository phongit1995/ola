.class Lchat/ola/vn/network/e$8;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->b(JS)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic b:S

.field final synthetic c:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;JS)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$8;->c:Lchat/ola/vn/network/e;

    iput-wide p2, p0, Lchat/ola/vn/network/e$8;->a:J

    iput-short p4, p0, Lchat/ola/vn/network/e$8;->b:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->g()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-wide v1, p0, Lchat/ola/vn/network/e$8;->a:J

    new-instance v3, Lchat/ola/vn/network/e$8$1;

    invoke-direct {v3, p0}, Lchat/ola/vn/network/e$8$1;-><init>(Lchat/ola/vn/network/e$8;)V

    invoke-virtual {v0, v1, v2, v3}, Lchat/ola/vn/network/OlaNetworkService;->b(JLchat/ola/vn/p/c;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/e$8;->c:Lchat/ola/vn/network/e;

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

    check-cast v1, Lchat/ola/vn/network/f;

    iget-wide v2, p0, Lchat/ola/vn/network/e$8;->a:J

    iget-short v4, p0, Lchat/ola/vn/network/e$8;->b:S

    invoke-interface {v1, v2, v3, v4}, Lchat/ola/vn/network/f;->b(JS)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    :cond_1
    :try_start_1
    iget-short v0, p0, Lchat/ola/vn/network/e$8;->b:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_2

    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-wide v3, p0, Lchat/ola/vn/network/e$8;->a:J

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    :catch_1
    :cond_2
    return-void
.end method
