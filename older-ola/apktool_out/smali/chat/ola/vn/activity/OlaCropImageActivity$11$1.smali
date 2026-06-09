.class Lchat/ola/vn/activity/OlaCropImageActivity$11$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/u/o;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaCropImageActivity$11;->a(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lchat/ola/vn/activity/OlaCropImageActivity$11;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaCropImageActivity$11;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$11;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->a:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private b(Ljava/lang/String;)V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$11;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$11;->a:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->dismiss()V

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$11;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaCropImageActivity$11;->b:Landroid/content/Context;

    const v0, 0x7f0f0385

    invoke-virtual {p1, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$11;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$11;->b:Landroid/content/Context;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$11;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaCropImageActivity$11;->b:Landroid/content/Context;

    const v2, 0x7f0f009f

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, p1}, Lchat/ola/vn/i/i;->b(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/Dialog;

    iget-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$11;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaCropImageActivity$11;->c:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$11;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaCropImageActivity$11;->c:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    invoke-interface {p1}, Lchat/ola/vn/activity/OlaCropImageActivity$a;->F()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method


# virtual methods
.method public a(II)V
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$11;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$11;->a:Landroid/app/ProgressDialog;

    invoke-virtual {v0, p2}, Landroid/app/ProgressDialog;->setMax(I)V

    iget-object p2, p0, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$11;

    iget-object p2, p2, Lchat/ola/vn/activity/OlaCropImageActivity$11;->a:Landroid/app/ProgressDialog;

    invoke-virtual {p2, p1}, Landroid/app/ProgressDialog;->setProgress(I)V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/i;)V
    .locals 13

    :try_start_0
    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v1, 0x1

    new-array v2, v1, [Ljava/lang/String;

    const-string v3, "avatar"

    const/4 v4, 0x0

    aput-object v3, v2, v4

    new-array v1, v1, [Ljava/lang/String;

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v4

    invoke-virtual {v0, v2, v1}, Lchat/ola/vn/network/OlaNetworkService;->b([Ljava/lang/String;[Ljava/lang/String;)V

    sget-object v5, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const v0, 0x7f0f01be

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object v7

    const/4 v8, 0x0

    const/4 v9, 0x2

    const/4 v10, 0x0

    const/4 v11, 0x0

    const/4 v12, 0x0

    invoke-virtual/range {v5 .. v12}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SSLjava/lang/String;Ljava/lang/String;S)V

    new-instance p1, Ljava/io/File;

    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->a:Ljava/lang/String;

    invoke-direct {p1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {p1}, Lcom/mg/ola/common/d/c;->c(Ljava/io/File;)Z

    new-instance p1, Lchat/ola/vn/activity/OlaCropImageActivity$11$1$1;

    invoke-direct {p1, p0}, Lchat/ola/vn/activity/OlaCropImageActivity$11$1$1;-><init>(Lchat/ola/vn/activity/OlaCropImageActivity$11$1;)V

    const-wide/16 v0, 0x3e8

    invoke-static {p1, v0, v1}, Lchat/ola/vn/OlaApplication;->a(Ljava/lang/Runnable;J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    const/4 p1, 0x0

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b(Ljava/lang/String;)V

    return-void
.end method

.method public a(Ljava/lang/String;I)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$11;

    iget-object p1, p1, Lchat/ola/vn/activity/OlaCropImageActivity$11;->b:Landroid/content/Context;

    const p2, 0x7f0f02e6

    invoke-virtual {p1, p2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b(Ljava/lang/String;)V

    return-void
.end method

.method public a(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    invoke-direct {p0, p3}, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b(Ljava/lang/String;)V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p2}, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b(Ljava/lang/String;)V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0, p2}, Lchat/ola/vn/activity/OlaCropImageActivity$11$1;->b(Ljava/lang/String;)V

    return-void
.end method
