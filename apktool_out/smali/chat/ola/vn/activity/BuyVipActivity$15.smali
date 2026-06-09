.class Lchat/ola/vn/activity/BuyVipActivity$15;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/activity/BuyVipActivity;->F()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/activity/BuyVipActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/activity/BuyVipActivity;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 6

    const/4 p1, 0x0

    if-eqz p2, :cond_1

    sget-boolean p2, Lchat/ola/vn/h;->a:Z

    if-eqz p2, :cond_1

    invoke-static {}, Lchat/ola/vn/activity/BuyVipActivity;->C()Ljava/util/List;

    move-result-object p2

    if-nez p2, :cond_0

    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/BuyVipActivity;->c(Lchat/ola/vn/activity/BuyVipActivity;)V

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/BuyVipActivity;->d(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/b/aa;

    move-result-object p2

    if-eqz p2, :cond_3

    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/BuyVipActivity;->d(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/b/aa;

    move-result-object p2

    invoke-static {}, Lchat/ola/vn/activity/BuyVipActivity;->C()Ljava/util/List;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/b/aa;->a(Ljava/util/List;)V

    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/BuyVipActivity;->d(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/b/aa;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/b/aa;->notifyDataSetChanged()V

    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {}, Lchat/ola/vn/activity/BuyVipActivity;->C()Ljava/util/List;

    move-result-object v0

    goto :goto_0

    :cond_1
    invoke-static {}, Lchat/ola/vn/activity/BuyVipActivity;->D()Ljava/util/List;

    move-result-object p2

    if-eqz p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/BuyVipActivity;->d(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/b/aa;

    move-result-object p2

    if-eqz p2, :cond_2

    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/BuyVipActivity;->d(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/b/aa;

    move-result-object p2

    invoke-static {}, Lchat/ola/vn/activity/BuyVipActivity;->D()Ljava/util/List;

    move-result-object v0

    invoke-virtual {p2, v0}, Lchat/ola/vn/b/aa;->a(Ljava/util/List;)V

    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/BuyVipActivity;->d(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/b/aa;

    move-result-object p2

    invoke-virtual {p2}, Lchat/ola/vn/b/aa;->notifyDataSetChanged()V

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {}, Lchat/ola/vn/activity/BuyVipActivity;->D()Ljava/util/List;

    move-result-object v0

    :goto_0
    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/entity/ac;

    invoke-static {p2, v0}, Lchat/ola/vn/activity/BuyVipActivity;->a(Lchat/ola/vn/activity/BuyVipActivity;Lchat/ola/vn/entity/ac;)Lchat/ola/vn/entity/ac;

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/BuyVipActivity;->e(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/entity/ac;

    move-result-object p2

    iget-object p2, p2, Lchat/ola/vn/entity/ac;->b:Ljava/lang/String;

    invoke-static {p2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    const/4 v0, 0x1

    const/4 v1, 0x2

    if-eqz p2, :cond_4

    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/BuyVipActivity;->f(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/view/OlaSuggestEditText;

    move-result-object p2

    iget-object v2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    const v3, 0x7f0f06f7

    new-array v1, v1, [Ljava/lang/Object;

    iget-object v4, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {v4}, Lchat/ola/vn/activity/BuyVipActivity;->e(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/entity/ac;

    move-result-object v4

    iget-wide v4, v4, Lchat/ola/vn/entity/ac;->c:J

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v1, p1

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->e(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/entity/ac;

    move-result-object p1

    iget p1, p1, Lchat/ola/vn/entity/ac;->d:I

    int-to-long v4, p1

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    aput-object p1, v1, v0

    :goto_1
    invoke-virtual {v2, v3, v1}, Lchat/ola/vn/activity/BuyVipActivity;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Lchat/ola/vn/view/OlaSuggestEditText;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_4
    iget-object p2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p2}, Lchat/ola/vn/activity/BuyVipActivity;->f(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/view/OlaSuggestEditText;

    move-result-object p2

    iget-object v2, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    const v3, 0x7f0f06f8

    new-array v1, v1, [Ljava/lang/Object;

    iget-object v4, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {v4}, Lchat/ola/vn/activity/BuyVipActivity;->e(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/entity/ac;

    move-result-object v4

    iget-object v4, v4, Lchat/ola/vn/entity/ac;->a:Ljava/lang/String;

    aput-object v4, v1, p1

    iget-object p1, p0, Lchat/ola/vn/activity/BuyVipActivity$15;->a:Lchat/ola/vn/activity/BuyVipActivity;

    invoke-static {p1}, Lchat/ola/vn/activity/BuyVipActivity;->e(Lchat/ola/vn/activity/BuyVipActivity;)Lchat/ola/vn/entity/ac;

    move-result-object p1

    iget p1, p1, Lchat/ola/vn/entity/ac;->d:I

    int-to-long v4, p1

    invoke-static {v4, v5}, Lchat/ola/vn/util/m;->a(J)Ljava/lang/String;

    move-result-object p1

    aput-object p1, v1, v0

    goto :goto_1

    return-void
.end method
