.class Lchat/ola/vn/m/w$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/w;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/w;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/w;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/w$3;->a:Lchat/ola/vn/m/w;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/m/w$3;->a:Lchat/ola/vn/m/w;

    invoke-virtual {v0}, Lchat/ola/vn/m/w;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/w$3;->a:Lchat/ola/vn/m/w;

    invoke-static {v1}, Lchat/ola/vn/m/w;->a(Lchat/ola/vn/m/w;)Landroid/widget/EditText;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    iget-object v0, p0, Lchat/ola/vn/m/w$3;->a:Lchat/ola/vn/m/w;

    invoke-static {v0}, Lchat/ola/vn/m/w;->a(Lchat/ola/vn/m/w;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    return-void
.end method
