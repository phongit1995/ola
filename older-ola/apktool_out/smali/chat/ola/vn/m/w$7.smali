.class Lchat/ola/vn/m/w$7;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/w;->a(Landroid/content/Context;)Ljava/util/ArrayList;
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

    iput-object p1, p0, Lchat/ola/vn/m/w$7;->a:Lchat/ola/vn/m/w;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/w$7;->a:Lchat/ola/vn/m/w;

    invoke-virtual {p1}, Lchat/ola/vn/m/w;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/w$7;->a:Lchat/ola/vn/m/w;

    invoke-static {v0}, Lchat/ola/vn/m/w;->a(Lchat/ola/vn/m/w;)Landroid/widget/EditText;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Landroid/view/View;Z)V

    iget-object p1, p0, Lchat/ola/vn/m/w$7;->a:Lchat/ola/vn/m/w;

    invoke-virtual {p1}, Lchat/ola/vn/m/w;->e()Lchat/ola/vn/m/g;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/m/g;->g_()Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
