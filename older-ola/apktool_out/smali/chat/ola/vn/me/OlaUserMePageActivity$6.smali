.class Lchat/ola/vn/me/OlaUserMePageActivity$6;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaUserMePageActivity;->aa()V
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

    iput-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$6;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iput-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$6;->a:Ljava/util/List;

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

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$6;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    const p2, 0x7f0f066c

    invoke-static {p2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$6;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p2, p2, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p2, p2, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;)Lchat/ola/vn/message/f;

    move-result-object p1

    if-eqz p1, :cond_2

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p3, p0, Lchat/ola/vn/me/OlaUserMePageActivity$6;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p3, p3, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p3, p3, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {p2, p3}, Lchat/ola/vn/network/OlaNetworkService;->e(Ljava/lang/String;)V

    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p2, p1}, Lchat/ola/vn/message/g;->d(Lchat/ola/vn/message/f;)V

    goto :goto_0

    :cond_0
    const p2, 0x7f0f057e

    invoke-static {p2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/4 p3, 0x0

    if-eqz p2, :cond_1

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$6;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p2, p2, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p2, p2, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    invoke-virtual {p1, p2, p3, p3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$6;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p1, p1, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iput-boolean p3, p1, Lchat/ola/vn/entity/ag;->y:Z

    goto :goto_0

    :cond_1
    const p2, 0x7f0f04f8

    invoke-static {p2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p2, p0, Lchat/ola/vn/me/OlaUserMePageActivity$6;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p2, p2, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iget-object p2, p2, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    const/4 p4, 0x1

    invoke-virtual {p1, p2, p4, p3}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;ZS)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$6;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    iget-object p1, p1, Lchat/ola/vn/me/OlaUserMePageActivity;->e:Lchat/ola/vn/entity/ag;

    iput-boolean p4, p1, Lchat/ola/vn/entity/ag;->y:Z

    :cond_2
    :goto_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaUserMePageActivity$6;->b:Lchat/ola/vn/me/OlaUserMePageActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaUserMePageActivity;->f(Lchat/ola/vn/me/OlaUserMePageActivity;)V

    return-void
.end method
