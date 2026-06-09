.class Lchat/ola/vn/network/e$10;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JS)V
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

.field final synthetic e:J

.field final synthetic f:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$10;->f:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$10;->a:Ljava/lang/String;

    iput-object p3, p0, Lchat/ola/vn/network/e$10;->b:Ljava/lang/String;

    iput-object p4, p0, Lchat/ola/vn/network/e$10;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/network/e$10;->d:Ljava/lang/String;

    iput-wide p6, p0, Lchat/ola/vn/network/e$10;->e:J

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/network/e$10;->a:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/network/e$10;->b:Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/network/e$10;->c:Ljava/lang/String;

    iget-object v4, p0, Lchat/ola/vn/network/e$10;->d:Ljava/lang/String;

    invoke-static {v0, v1, v2, v3, v4}, Lchat/ola/vn/h/b;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lchat/ola/vn/network/e$10;->f:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v1, p0, Lchat/ola/vn/network/e$10;->a:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    iget-wide v0, p0, Lchat/ola/vn/network/e$10;->e:J

    const-wide/16 v2, 0x0

    cmp-long v4, v0, v2

    if-lez v4, :cond_0

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f0f0295

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-wide v4, p0, Lchat/ola/vn/network/e$10;->e:J

    invoke-static {v4, v5}, Lcom/mg/ola/common/d/i;->a(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v1, v2}, Lchat/ola/vn/OlaApplication;->a(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/j;->c(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_0
    :try_start_2
    iget-object v0, p0, Lchat/ola/vn/network/e$10;->f:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/network/e$10;->f:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-nez v0, :cond_1

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/network/e$10;->f:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v0, v0, Lchat/ola/vn/network/OlaNetworkService;->j:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/network/f;

    invoke-interface {v1}, Lchat/ola/vn/network/f;->w()V

    goto :goto_0

    :cond_2
    :goto_1
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/c;->w()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_3
    return-void
.end method
