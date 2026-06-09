.class Lchat/ola/vn/signup/e$2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/signup/e;->b(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/signup/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/signup/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/signup/e$2;->a:Lchat/ola/vn/signup/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/signup/e$2;->a:Lchat/ola/vn/signup/e;

    invoke-virtual {v0}, Lchat/ola/vn/signup/e;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/signup/e$2;->a:Lchat/ola/vn/signup/e;

    invoke-static {v1}, Lchat/ola/vn/signup/e;->a(Lchat/ola/vn/signup/e;)Landroid/widget/EditText;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
