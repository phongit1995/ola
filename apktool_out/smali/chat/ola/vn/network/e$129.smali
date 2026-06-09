.class Lchat/ola/vn/network/e$129;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->i(Ljava/lang/String;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:S

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;SLjava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$129;->c:Lchat/ola/vn/network/e;

    iput-short p2, p0, Lchat/ola/vn/network/e$129;->a:S

    iput-object p3, p0, Lchat/ola/vn/network/e$129;->b:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 10

    const/4 v0, 0x1

    const/4 v1, 0x0

    :try_start_0
    iget-short v2, p0, Lchat/ola/vn/network/e$129;->a:S

    invoke-static {v2}, Lchat/ola/vn/entry/c/f;->b(S)Lchat/ola/vn/entry/c/e;

    move-result-object v2

    if-eqz v2, :cond_0

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    iget-object v4, p0, Lchat/ola/vn/network/e$129;->b:Ljava/lang/String;

    aput-object v4, v3, v1

    iget-short v4, p0, Lchat/ola/vn/network/e$129;->a:S

    invoke-static {v4}, Ljava/lang/Short;->valueOf(S)Ljava/lang/Short;

    move-result-object v4

    aput-object v4, v3, v0

    invoke-virtual {v2, v3}, Lchat/ola/vn/entry/c/e;->a([Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    :try_start_1
    iget-object v2, p0, Lchat/ola/vn/network/e$129;->b:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_1

    sget-object v2, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    iget-object v3, p0, Lchat/ola/vn/network/e$129;->b:Ljava/lang/String;

    invoke-virtual {v2, v3}, Lchat/ola/vn/r/a/e;->c(Ljava/lang/String;)V

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v2

    const v3, 0x7f0f020d

    new-array v4, v0, [Ljava/lang/Object;

    iget-object v5, p0, Lchat/ola/vn/network/e$129;->b:Ljava/lang/String;

    aput-object v5, v4, v1

    invoke-static {v2, v3, v4}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I[Ljava/lang/Object;)V

    sget-object v2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    if-eqz v2, :cond_1

    iget-object v2, p0, Lchat/ola/vn/network/e$129;->b:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->k(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    sget-object v4, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const v3, 0x7f0f026f

    new-array v0, v0, [Ljava/lang/Object;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "\"#"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "\""

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    invoke-static {v3, v0}, Lchat/ola/vn/OlaApplication;->a(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    invoke-virtual/range {v4 .. v9}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SLjava/lang/String;S)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :catch_1
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method
