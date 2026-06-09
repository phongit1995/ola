.class Lchat/ola/vn/network/e$77;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;ISLjava/lang/String;JLjava/util/List;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:S

.field final synthetic d:Ljava/lang/String;

.field final synthetic e:J

.field final synthetic f:Ljava/util/List;

.field final synthetic g:S

.field final synthetic h:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;ILjava/lang/String;SLjava/lang/String;JLjava/util/List;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$77;->h:Lchat/ola/vn/network/e;

    iput p2, p0, Lchat/ola/vn/network/e$77;->a:I

    iput-object p3, p0, Lchat/ola/vn/network/e$77;->b:Ljava/lang/String;

    iput-short p4, p0, Lchat/ola/vn/network/e$77;->c:S

    iput-object p5, p0, Lchat/ola/vn/network/e$77;->d:Ljava/lang/String;

    iput-wide p6, p0, Lchat/ola/vn/network/e$77;->e:J

    iput-object p8, p0, Lchat/ola/vn/network/e$77;->f:Ljava/util/List;

    iput-short p9, p0, Lchat/ola/vn/network/e$77;->g:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 11

    :try_start_0
    iget v0, p0, Lchat/ola/vn/network/e$77;->a:I

    sput v0, Lchat/ola/vn/h;->K:I

    iget-object v0, p0, Lchat/ola/vn/network/e$77;->h:Lchat/ola/vn/network/e;

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

    iget-object v3, p0, Lchat/ola/vn/network/e$77;->b:Ljava/lang/String;

    iget v4, p0, Lchat/ola/vn/network/e$77;->a:I

    iget-short v5, p0, Lchat/ola/vn/network/e$77;->c:S

    iget-object v6, p0, Lchat/ola/vn/network/e$77;->d:Ljava/lang/String;

    iget-wide v7, p0, Lchat/ola/vn/network/e$77;->e:J

    iget-object v9, p0, Lchat/ola/vn/network/e$77;->f:Ljava/util/List;

    iget-short v10, p0, Lchat/ola/vn/network/e$77;->g:S

    invoke-interface/range {v2 .. v10}, Lchat/ola/vn/network/f;->a(Ljava/lang/String;ISLjava/lang/String;JLjava/util/List;S)V

    goto :goto_0

    :cond_0
    iget-short v0, p0, Lchat/ola/vn/network/e$77;->g:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_1

    const/4 v1, 0x6

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/network/e$77;->b:Ljava/lang/String;

    aput-object v3, v1, v2

    const/4 v2, 0x1

    iget v3, p0, Lchat/ola/vn/network/e$77;->a:I

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x2

    iget-short v3, p0, Lchat/ola/vn/network/e$77;->c:S

    invoke-static {v3}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x3

    iget-object v3, p0, Lchat/ola/vn/network/e$77;->d:Ljava/lang/String;

    aput-object v3, v1, v2

    const/4 v2, 0x4

    iget-wide v3, p0, Lchat/ola/vn/network/e$77;->e:J

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x5

    iget-object v3, p0, Lchat/ola/vn/network/e$77;->f:Ljava/util/List;

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method
