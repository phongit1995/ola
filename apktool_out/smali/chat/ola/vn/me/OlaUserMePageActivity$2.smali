.class Lchat/ola/vn/me/OlaUserMePageActivity$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaUserMePageActivity;->X()V
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

    iput-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iput-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->a:Ljava/util/List;

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
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    const p3, 0x7f0f0439

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_0

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p2, p2, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p2, p2, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {p1, p2}, Lchat/ola/vn/network/OlaNetworkService;->m(Ljava/lang/String;)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p1, p1, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    const/4 p2, 0x1

    iput-boolean p2, p1, Lchat/ola/vn/entity/ag;->A:Z

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p1, p1, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    const/4 p2, 0x0

    iput-boolean p2, p1, Lchat/ola/vn/entity/ag;->y:Z

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->f(Lchat/ola/vn/me/OlaUserMePageActivity;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    const p3, 0x7f0f0492

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    const-string p3, "@"

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object p3, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p3, p3, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p3, p3, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    const p3, 0x7f0f042f

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaUserMePageActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$2;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p2, p2, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p2, p2, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-static {p1, p2}, Lchat/ola/vn/i/i;->a(Landroid/content/Context;Ljava/lang/String;)Lchat/ola/vn/i/p;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method
