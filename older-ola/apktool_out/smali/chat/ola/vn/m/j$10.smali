.class Lchat/ola/vn/m/j$10;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/support/v4/view/ViewPager$OnPageChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/j;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/j;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/j;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$10;->a:Lchat/ola/vn/m/j;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPageScrollStateChanged(I)V
    .locals 3

    if-nez p1, :cond_1

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/j$10;->a:Lchat/ola/vn/m/j;

    invoke-static {p1}, Lchat/ola/vn/m/j;->c(Lchat/ola/vn/m/j;)Lchat/ola/vn/m/c;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/j$10;->a:Lchat/ola/vn/m/j;

    invoke-static {p1}, Lchat/ola/vn/m/j;->c(Lchat/ola/vn/m/j;)Lchat/ola/vn/m/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/m/c;->h()V

    iget-object p1, p0, Lchat/ola/vn/m/j$10;->a:Lchat/ola/vn/m/j;

    invoke-static {p1}, Lchat/ola/vn/m/j;->c(Lchat/ola/vn/m/j;)Lchat/ola/vn/m/c;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/m/c;->c()V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/j$10;->a:Lchat/ola/vn/m/j;

    invoke-static {p1}, Lchat/ola/vn/m/j;->d(Lchat/ola/vn/m/j;)Lcom/mg/ola/common/widget/OlaViewPager;

    move-result-object p1

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/OlaViewPager;->getCurrentItem()I

    move-result p1

    iget-object v0, p0, Lchat/ola/vn/m/j$10;->a:Lchat/ola/vn/m/j;

    iget-object v1, p0, Lchat/ola/vn/m/j$10;->a:Lchat/ola/vn/m/j;

    invoke-static {v1}, Lchat/ola/vn/m/j;->e(Lchat/ola/vn/m/j;)Lchat/ola/vn/m/j$a;

    move-result-object v1

    iget-object v2, p0, Lchat/ola/vn/m/j$10;->a:Lchat/ola/vn/m/j;

    invoke-static {v2}, Lchat/ola/vn/m/j;->d(Lchat/ola/vn/m/j;)Lcom/mg/ola/common/widget/OlaViewPager;

    move-result-object v2

    invoke-virtual {v1, v2, p1}, Lchat/ola/vn/m/j$a;->a(Landroid/support/v4/view/ViewPager;I)Landroid/support/v4/app/Fragment;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/m/c;

    invoke-static {v0, v1}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/m/j;Lchat/ola/vn/m/c;)Lchat/ola/vn/m/c;

    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entity/t;

    sput-object p1, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    iget-object p1, p0, Lchat/ola/vn/m/j$10;->a:Lchat/ola/vn/m/j;

    invoke-static {p1}, Lchat/ola/vn/m/j;->c(Lchat/ola/vn/m/j;)Lchat/ola/vn/m/c;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/m/j;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p1, v0}, Lchat/ola/vn/m/c;->a(Lchat/ola/vn/entity/t;)V

    iget-object p1, p0, Lchat/ola/vn/m/j$10;->a:Lchat/ola/vn/m/j;

    invoke-virtual {p1}, Lchat/ola/vn/m/j;->d()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method public onPageScrolled(IFI)V
    .locals 0

    return-void
.end method

.method public onPageSelected(I)V
    .locals 0

    return-void
.end method
