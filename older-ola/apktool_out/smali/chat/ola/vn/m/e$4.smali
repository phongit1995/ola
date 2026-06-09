.class Lchat/ola/vn/m/e$4;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/e;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/e$4;->a:Lchat/ola/vn/m/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result p1

    packed-switch p1, :pswitch_data_0

    return-void

    :pswitch_0
    invoke-static {}, Lchat/ola/vn/m/e;->h()Ljava/lang/ref/WeakReference;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/m/e;

    invoke-static {p1}, Lchat/ola/vn/m/e;->b(Lchat/ola/vn/m/e;)S

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/e$4;->a:Lchat/ola/vn/m/e;

    :goto_0
    invoke-static {p1}, Lchat/ola/vn/m/e;->c(Lchat/ola/vn/m/e;)Lchat/ola/vn/m/p;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/m/p;->f_()V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/e$4;->a:Lchat/ola/vn/m/e;

    const/4 v0, 0x0

    iget-object v1, p0, Lchat/ola/vn/m/e$4;->a:Lchat/ola/vn/m/e;

    :goto_1
    invoke-virtual {v1}, Lchat/ola/vn/m/e;->getArguments()Landroid/os/Bundle;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lchat/ola/vn/m/e;->a(Lchat/ola/vn/m/e;SLandroid/os/Bundle;)V

    return-void

    :pswitch_1
    invoke-static {}, Lchat/ola/vn/m/e;->h()Ljava/lang/ref/WeakReference;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/m/e;

    invoke-static {p1}, Lchat/ola/vn/m/e;->b(Lchat/ola/vn/m/e;)S

    move-result p1

    const/4 v0, 0x1

    if-ne p1, v0, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/e$4;->a:Lchat/ola/vn/m/e;

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/m/e$4;->a:Lchat/ola/vn/m/e;

    iget-object v1, p0, Lchat/ola/vn/m/e$4;->a:Lchat/ola/vn/m/e;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f090122
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
