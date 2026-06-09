.class Lchat/ola/vn/network/e$58;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(JLjava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Ljava/util/List;

.field final synthetic e:Ljava/util/List;

.field final synthetic f:S

.field final synthetic g:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;JLjava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;S)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$58;->g:Lchat/ola/vn/network/e;

    iput-wide p2, p0, Lchat/ola/vn/network/e$58;->a:J

    iput-object p4, p0, Lchat/ola/vn/network/e$58;->b:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/network/e$58;->c:Ljava/lang/String;

    iput-object p6, p0, Lchat/ola/vn/network/e$58;->d:Ljava/util/List;

    iput-object p7, p0, Lchat/ola/vn/network/e$58;->e:Ljava/util/List;

    iput-short p8, p0, Lchat/ola/vn/network/e$58;->f:S

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 11

    :try_start_0
    new-instance v0, Lchat/ola/vn/entity/s;

    iget-wide v1, p0, Lchat/ola/vn/network/e$58;->a:J

    iget-object v3, p0, Lchat/ola/vn/network/e$58;->b:Ljava/lang/String;

    invoke-direct {v0, v1, v2, v3}, Lchat/ola/vn/entity/s;-><init>(JLjava/lang/String;)V

    iget-object v1, p0, Lchat/ola/vn/network/e$58;->c:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/s;->c(Ljava/lang/String;)V

    sget-object v1, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    iget-object v2, p0, Lchat/ola/vn/network/e$58;->d:Ljava/util/List;

    invoke-virtual {v1, v0, v2}, Lchat/ola/vn/r/a/f;->a(Lchat/ola/vn/entity/s;Ljava/util/List;)V

    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    iget-object v1, p0, Lchat/ola/vn/network/e$58;->e:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/a/f;->b(Ljava/util/List;)V

    sget-object v0, Lchat/ola/vn/h;->x:Lchat/ola/vn/r/a/f;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/a/f;->a(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/network/e$58;->g:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    move-object v3, v2

    check-cast v3, Lchat/ola/vn/network/f;

    iget-wide v4, p0, Lchat/ola/vn/network/e$58;->a:J

    iget-object v6, p0, Lchat/ola/vn/network/e$58;->b:Ljava/lang/String;

    iget-object v7, p0, Lchat/ola/vn/network/e$58;->c:Ljava/lang/String;

    iget-object v8, p0, Lchat/ola/vn/network/e$58;->d:Ljava/util/List;

    iget-object v9, p0, Lchat/ola/vn/network/e$58;->e:Ljava/util/List;

    iget-short v10, p0, Lchat/ola/vn/network/e$58;->f:S

    invoke-interface/range {v3 .. v10}, Lchat/ola/vn/network/f;->a(JLjava/lang/String;Ljava/lang/String;Ljava/util/List;Ljava/util/List;S)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_0

    :catch_0
    :cond_0
    :try_start_2
    iget-short v0, p0, Lchat/ola/vn/network/e$58;->f:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v0

    if-eqz v0, :cond_1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    const-string v3, ""

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_1
    return-void
.end method
