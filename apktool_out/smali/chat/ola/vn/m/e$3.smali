.class Lchat/ola/vn/m/e$3;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/support/v4/view/ViewPager$OnPageChangeListener;


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

    iput-object p1, p0, Lchat/ola/vn/m/e$3;->a:Lchat/ola/vn/m/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPageScrollStateChanged(I)V
    .locals 0

    return-void
.end method

.method public onPageScrolled(IFI)V
    .locals 0

    return-void
.end method

.method public onPageSelected(I)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/e$3;->a:Lchat/ola/vn/m/e;

    iget-object v1, p0, Lchat/ola/vn/m/e$3;->a:Lchat/ola/vn/m/e;

    invoke-static {v1, p1}, Lchat/ola/vn/m/e;->a(Lchat/ola/vn/m/e;I)Lchat/ola/vn/m/p;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/m/e;->a(Lchat/ola/vn/m/e;Lchat/ola/vn/m/p;)Lchat/ola/vn/m/p;

    iget-object v0, p0, Lchat/ola/vn/m/e$3;->a:Lchat/ola/vn/m/e;

    int-to-short p1, p1

    invoke-static {v0, p1}, Lchat/ola/vn/m/e;->a(Lchat/ola/vn/m/e;S)S

    iget-object p1, p0, Lchat/ola/vn/m/e$3;->a:Lchat/ola/vn/m/e;

    invoke-virtual {p1}, Lchat/ola/vn/m/e;->e()V

    iget-object p1, p0, Lchat/ola/vn/m/e$3;->a:Lchat/ola/vn/m/e;

    invoke-static {p1}, Lchat/ola/vn/m/e;->a(Lchat/ola/vn/m/e;)V

    return-void
.end method
