.class Lchat/ola/vn/me/OlaPeopleListActivity$2;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaPeopleListActivity;->f(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/OlaPeopleListActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaPeopleListActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity$2;->a:Lchat/ola/vn/me/OlaPeopleListActivity;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/16 v0, 0x45

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    const/16 p2, 0x8

    const/16 p3, 0x22

    if-ne p1, p3, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity$2;->a:Lchat/ola/vn/me/OlaPeopleListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaPeopleListActivity;->a(Lchat/ola/vn/me/OlaPeopleListActivity;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity$2;->a:Lchat/ola/vn/me/OlaPeopleListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaPeopleListActivity;->b(Lchat/ola/vn/me/OlaPeopleListActivity;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity$2;->a:Lchat/ola/vn/me/OlaPeopleListActivity;

    const/4 p3, 0x0

    iput-object p3, p1, Lchat/ola/vn/me/OlaPeopleListActivity;->e:Ljava/lang/String;

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity$2;->a:Lchat/ola/vn/me/OlaPeopleListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaPeopleListActivity;->a(Lchat/ola/vn/me/OlaPeopleListActivity;)Landroid/view/View;

    move-result-object p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity$2;->a:Lchat/ola/vn/me/OlaPeopleListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaPeopleListActivity;->a(Lchat/ola/vn/me/OlaPeopleListActivity;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaPeopleListActivity$2;->a:Lchat/ola/vn/me/OlaPeopleListActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaPeopleListActivity;->b(Lchat/ola/vn/me/OlaPeopleListActivity;)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p2}, Landroid/view/View;->setVisibility(I)V

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 2

    const/4 v0, 0x0

    aget-object v0, p1, v0

    check-cast v0, [Ljava/lang/String;

    const/4 v1, 0x1

    aget-object p1, p1, v1

    check-cast p1, Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/me/OlaPeopleListActivity$2;->a:Lchat/ola/vn/me/OlaPeopleListActivity;

    invoke-virtual {v1, p1, v0}, Lchat/ola/vn/me/OlaPeopleListActivity;->a(Ljava/lang/String;[Ljava/lang/String;)V

    return-void
.end method
