.class Lchat/ola/vn/network/e$122;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->b(JIS)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic b:I

.field final synthetic c:S

.field final synthetic d:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;JIS)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$122;->d:Lchat/ola/vn/network/e;

    iput-wide p2, p0, Lchat/ola/vn/network/e$122;->a:J

    iput p4, p0, Lchat/ola/vn/network/e$122;->b:I

    iput-short p5, p0, Lchat/ola/vn/network/e$122;->c:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/e$122;->d:Lchat/ola/vn/network/e;

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

    iget-wide v2, p0, Lchat/ola/vn/network/e$122;->a:J

    iget v4, p0, Lchat/ola/vn/network/e$122;->b:I

    iget-short v5, p0, Lchat/ola/vn/network/e$122;->c:S

    invoke-interface {v1, v2, v3, v4, v5}, Lchat/ola/vn/network/f;->b(JIS)V

    goto :goto_0

    :cond_0
    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    iget v1, p0, Lchat/ola/vn/network/e$122;->b:I

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/a/e;->d(I)V

    iget-short v0, p0, Lchat/ola/vn/network/e$122;->c:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_1

    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-wide v3, p0, Lchat/ola/vn/network/e$122;->a:J

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x1

    iget v3, p0, Lchat/ola/vn/network/e$122;->b:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x2

    iget-short v3, p0, Lchat/ola/vn/network/e$122;->c:S

    invoke-static {v3}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
