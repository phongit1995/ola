.class Lchat/ola/vn/q/b$1;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/q/b;->a(Landroid/content/Context;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Landroid/content/Context;

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Lchat/ola/vn/message/f;

.field final synthetic e:Lchat/ola/vn/q/b;


# direct methods
.method constructor <init>(Lchat/ola/vn/q/b;Ljava/util/List;Landroid/content/Context;Ljava/lang/String;Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/q/b$1;->e:Lchat/ola/vn/q/b;

    iput-object p2, p0, Lchat/ola/vn/q/b$1;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/q/b$1;->b:Landroid/content/Context;

    iput-object p4, p0, Lchat/ola/vn/q/b$1;->c:Ljava/lang/String;

    iput-object p5, p0, Lchat/ola/vn/q/b$1;->d:Lchat/ola/vn/message/f;

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
    iget-object p1, p0, Lchat/ola/vn/q/b$1;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/q/b$1;->b:Landroid/content/Context;

    const p3, 0x7f0f0550

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_0

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/q/b$1;->b:Landroid/content/Context;

    const p3, 0x7f0f0465

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/q/b$1;->b:Landroid/content/Context;

    sget-object p2, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object p3, p0, Lchat/ola/vn/q/b$1;->c:Ljava/lang/String;

    const/4 p4, 0x0

    invoke-static {p1, p2, p3, p4}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;S)V

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/q/b$1;->b:Landroid/content/Context;

    const p3, 0x7f0f06a7

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/q/b$1;->b:Landroid/content/Context;

    iget-object p2, p0, Lchat/ola/vn/q/b$1;->c:Ljava/lang/String;

    invoke-static {p1, p2}, Lchat/ola/vn/activity/OlaVipStoreActivity;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/q/b$1;->b:Landroid/content/Context;

    const p3, 0x7f0f056b

    invoke-virtual {p2, p3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/q/b$1;->e:Lchat/ola/vn/q/b;

    iget-object p2, p0, Lchat/ola/vn/q/b$1;->b:Landroid/content/Context;

    iget-object p3, p0, Lchat/ola/vn/q/b$1;->d:Lchat/ola/vn/message/f;

    iget-object p4, p0, Lchat/ola/vn/q/b$1;->c:Ljava/lang/String;

    invoke-static {p1, p2, p3, p4}, Lchat/ola/vn/q/b;->a(Lchat/ola/vn/q/b;Landroid/content/Context;Lchat/ola/vn/message/f;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method
