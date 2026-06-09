.class Lchat/ola/vn/m/s$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/support/v4/view/ViewPager$OnPageChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/s;->a(Landroid/widget/ListView;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/s;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/s;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/s$2;->a:Lchat/ola/vn/m/s;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPageScrollStateChanged(I)V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/m/s$2;->a:Lchat/ola/vn/m/s;

    invoke-static {v0}, Lchat/ola/vn/m/s;->a(Lchat/ola/vn/m/s;)Lcom/mg/ola/common/widget/OlaViewPager;

    move-result-object v0

    iget-object v1, p0, Lchat/ola/vn/m/s$2;->a:Lchat/ola/vn/m/s;

    invoke-static {v1}, Lchat/ola/vn/m/s;->b(Lchat/ola/vn/m/s;)Ljava/lang/Runnable;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/mg/ola/common/widget/OlaViewPager;->removeCallbacks(Ljava/lang/Runnable;)Z

    if-eqz p1, :cond_0

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/s$2;->a:Lchat/ola/vn/m/s;

    invoke-static {p1}, Lchat/ola/vn/m/s;->a(Lchat/ola/vn/m/s;)Lcom/mg/ola/common/widget/OlaViewPager;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/m/s$2;->a:Lchat/ola/vn/m/s;

    invoke-static {v0}, Lchat/ola/vn/m/s;->b(Lchat/ola/vn/m/s;)Ljava/lang/Runnable;

    move-result-object v0

    const-wide/16 v1, 0x1388

    invoke-virtual {p1, v0, v1, v2}, Lcom/mg/ola/common/widget/OlaViewPager;->postDelayed(Ljava/lang/Runnable;J)Z

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
