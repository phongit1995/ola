.class final Lchat/ola/vn/activity/OlaCropImageActivity$3;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/activity/OlaCropImageActivity$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/OlaCropImageActivity;->e(Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;

.field final synthetic b:Lchat/ola/vn/activity/OlaCropImageActivity$a;


# direct methods
.method constructor <init>(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3;->a:Landroid/content/Context;

    iput-object p2, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3;->b:Lchat/ola/vn/activity/OlaCropImageActivity$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;)V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3;->a:Landroid/content/Context;

    iget-object v1, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3;->a:Landroid/content/Context;

    const v2, 0x7f0f05ad

    invoke-virtual {v1, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/activity/OlaCropImageActivity$3;->a:Landroid/content/Context;

    const v3, 0x7f0f01c7

    invoke-virtual {v2, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Landroid/app/ProgressDialog;

    move-result-object v0

    new-instance v1, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;

    invoke-direct {v1, p0, v0, p1}, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;-><init>(Lchat/ola/vn/activity/OlaCropImageActivity$3;Landroid/app/ProgressDialog;Ljava/lang/String;)V

    const/4 p1, 0x0

    new-array p1, p1, [Ljava/lang/Void;

    invoke-virtual {v1, p1}, Lchat/ola/vn/activity/OlaCropImageActivity$3$1;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
