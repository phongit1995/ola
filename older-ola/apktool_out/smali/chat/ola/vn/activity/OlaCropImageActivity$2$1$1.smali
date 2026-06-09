.class Lchat/ola/vn/activity/OlaCropImageActivity$2$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaCropImageActivity$2$1;->a(Lchat/ola/vn/entity/i;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaCropImageActivity$2$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaCropImageActivity$2$1;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2$1$1;->a:Lchat/ola/vn/activity/OlaCropImageActivity$2$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2$1$1;->a:Lchat/ola/vn/activity/OlaCropImageActivity$2$1;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$2$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$2;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$2;->a:Landroid/app/ProgressDialog;

    invoke-virtual {v0}, Landroid/app/ProgressDialog;->dismiss()V

    const/4 v0, 0x1

    sput-boolean v0, Lchat/ola/vn/r/a/e;->e:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    :try_start_1
    invoke-static {}, Lchat/ola/vn/c/t;->a()Lchat/ola/vn/c/t;

    move-result-object v1

    invoke-virtual {v1, v0}, Lchat/ola/vn/c/t;->b(Z)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    iget-object v1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2$1$1;->a:Lchat/ola/vn/activity/OlaCropImageActivity$2$1;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaCropImageActivity$2$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$2;

    iget-object v1, v1, Lchat/ola/vn/activity/OlaCropImageActivity$2;->b:Landroid/content/Context;

    iget-object v2, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2$1$1;->a:Lchat/ola/vn/activity/OlaCropImageActivity$2$1;

    iget-object v2, v2, Lchat/ola/vn/activity/OlaCropImageActivity$2$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$2;

    iget-object v2, v2, Lchat/ola/vn/activity/OlaCropImageActivity$2;->b:Landroid/content/Context;

    const v3, 0x7f0f01b1

    new-array v0, v0, [Ljava/lang/Object;

    const/4 v4, 0x0

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "#"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v6, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2$1$1;->a:Lchat/ola/vn/activity/OlaCropImageActivity$2$1;

    iget-object v6, v6, Lchat/ola/vn/activity/OlaCropImageActivity$2$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$2;

    iget-object v6, v6, Lchat/ola/vn/activity/OlaCropImageActivity$2;->c:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v0, v4

    invoke-virtual {v2, v3, v0}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Lchat/ola/vn/util/j;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :try_start_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2$1$1;->a:Lchat/ola/vn/activity/OlaCropImageActivity$2$1;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$2$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$2;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$2;->d:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$2$1$1;->a:Lchat/ola/vn/activity/OlaCropImageActivity$2$1;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$2$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$2;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$2;->d:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    invoke-interface {v0}, Lchat/ola/vn/activity/OlaCropImageActivity$a;->E()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    :cond_0
    return-void
.end method
