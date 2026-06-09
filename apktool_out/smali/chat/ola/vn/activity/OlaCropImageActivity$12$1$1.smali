.class Lchat/ola/vn/activity/OlaCropImageActivity$12$1$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaCropImageActivity$12$1;->a(Lchat/ola/vn/entity/i;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/OlaCropImageActivity$12$1;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/OlaCropImageActivity$12$1;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$12$1$1;->a:Lchat/ola/vn/activity/OlaCropImageActivity$12$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$12$1$1;->a:Lchat/ola/vn/activity/OlaCropImageActivity$12$1;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$12$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$12;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$12;->a:Landroid/app/ProgressDialog;

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
    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$12$1$1;->a:Lchat/ola/vn/activity/OlaCropImageActivity$12$1;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$12$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$12;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$12;->b:Landroid/content/Context;

    const v1, 0x7f0f01b9

    invoke-static {v0, v1}, Lchat/ola/vn/util/j;->b(Landroid/content/Context;I)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :try_start_3
    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$12$1$1;->a:Lchat/ola/vn/activity/OlaCropImageActivity$12$1;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$12$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$12;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$12;->c:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$12$1$1;->a:Lchat/ola/vn/activity/OlaCropImageActivity$12$1;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$12$1;->b:Lchat/ola/vn/activity/OlaCropImageActivity$12;

    iget-object v0, v0, Lchat/ola/vn/activity/OlaCropImageActivity$12;->c:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    invoke-interface {v0}, Lchat/ola/vn/activity/OlaCropImageActivity$a;->E()V
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    :catch_2
    :cond_0
    return-void
.end method
