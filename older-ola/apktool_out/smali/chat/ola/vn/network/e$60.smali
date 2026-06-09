.class Lchat/ola/vn/network/e$60;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/Short;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/Short;

.field final synthetic b:I

.field final synthetic c:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/Short;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$60;->c:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$60;->a:Ljava/lang/Short;

    iput p3, p0, Lchat/ola/vn/network/e$60;->b:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 9

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/e$60;->c:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v0, :cond_5

    iget-object v0, p0, Lchat/ola/vn/network/e$60;->c:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v0}, Lchat/ola/vn/network/OlaNetworkService;->h()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/e$60;->a:Ljava/lang/Short;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/network/e$60;->a:Ljava/lang/Short;

    invoke-virtual {v0}, Ljava/lang/Short;->shortValue()S

    move-result v0

    sput-short v0, Lchat/ola/vn/h;->H:S

    sget-object v0, Lchat/ola/vn/h;->O:Lchat/ola/vn/entity/ag;

    sget-short v1, Lchat/ola/vn/h;->H:S

    iput-short v1, v0, Lchat/ola/vn/entity/ag;->u:S

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/network/e$60;->c:Lchat/ola/vn/network/e;

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

    check-cast v1, Lchat/ola/vn/network/f;

    iget-object v2, p0, Lchat/ola/vn/network/e$60;->a:Ljava/lang/Short;

    iget v3, p0, Lchat/ola/vn/network/e$60;->b:I

    invoke-interface {v1, v2, v3}, Lchat/ola/vn/network/f;->a(Ljava/lang/Short;I)V

    goto :goto_0

    :cond_2
    iget-object v0, p0, Lchat/ola/vn/network/e$60;->c:Lchat/ola/vn/network/e;

    iget-object v0, v0, Lchat/ola/vn/network/e;->a:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->d(S)V

    invoke-static {}, Lchat/ola/vn/h/b;->a()J

    move-result-wide v0

    sput-wide v0, Lchat/ola/vn/h;->E:J

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iget v2, p0, Lchat/ola/vn/network/e$60;->b:I

    const-wide/16 v3, 0x2710

    if-lez v2, :cond_4

    iget v2, p0, Lchat/ola/vn/network/e$60;->b:I

    const/4 v5, 0x3

    if-ge v2, v5, :cond_4

    sget-wide v5, Lchat/ola/vn/h;->E:J

    const/4 v2, 0x0

    sub-long v7, v0, v5

    const-wide/32 v5, 0x5265c00

    cmp-long v2, v7, v5

    if-ltz v2, :cond_5

    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/c/b;->b(Landroid/content/Context;)V

    goto :goto_1

    :cond_3
    new-instance v2, Lchat/ola/vn/network/e$60$1;

    invoke-direct {v2, p0}, Lchat/ola/vn/network/e$60$1;-><init>(Lchat/ola/vn/network/e$60;)V

    invoke-static {v2, v3, v4}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V

    :goto_1
    sput-wide v0, Lchat/ola/vn/h;->E:J

    sget-wide v0, Lchat/ola/vn/h;->E:J

    invoke-static {v0, v1}, Lchat/ola/vn/h/b;->a(J)V

    return-void

    :cond_4
    iget v2, p0, Lchat/ola/vn/network/e$60;->b:I

    if-gez v2, :cond_5

    sget-short v2, Lchat/ola/vn/h;->H:S

    if-nez v2, :cond_5

    sget-wide v5, Lchat/ola/vn/h;->E:J

    const/4 v2, 0x0

    sub-long v7, v0, v5

    const-wide/32 v5, 0xf731400

    cmp-long v2, v7, v5

    if-ltz v2, :cond_5

    invoke-static {}, Lchat/ola/vn/OlaApplication;->e()Z

    move-result v2

    if-nez v2, :cond_5

    new-instance v2, Lchat/ola/vn/network/e$60$2;

    invoke-direct {v2, p0, v0, v1}, Lchat/ola/vn/network/e$60$2;-><init>(Lchat/ola/vn/network/e$60;J)V

    invoke-static {v2, v3, v4}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    :cond_5
    return-void
.end method
