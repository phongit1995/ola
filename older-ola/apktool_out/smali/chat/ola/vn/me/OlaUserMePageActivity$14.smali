.class Lchat/ola/vn/me/OlaUserMePageActivity$14;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaUserMePageActivity;->W()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/me/OlaUserMePageActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaUserMePageActivity;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$14;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iput-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$14;->a:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)V"
        }
    .end annotation

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$14;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$14;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    const p3, 0x7f0f0461

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$14;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$14;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->c(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$14;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    const p3, 0x7f0f0459

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$14;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$14;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaCropImageActivity;->b(Landroid/content/Context;Lchat/ola/vn/activity/OlaCropImageActivity$a;)V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$14;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    const p3, 0x7f0f045c

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$14;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->g(Lchat/ola/vn/me/OlaUserMePageActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method
