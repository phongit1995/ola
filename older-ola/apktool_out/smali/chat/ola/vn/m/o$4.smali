.class Lchat/ola/vn/m/o$4;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/o;->c(Lchat/ola/vn/message/f;Landroid/view/View;Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/message/f;

.field final synthetic c:Lchat/ola/vn/m/o;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/o;Ljava/util/List;Lchat/ola/vn/message/f;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/o$4;->c:Lchat/ola/vn/m/o;

    iput-object p2, p0, Lchat/ola/vn/m/o$4;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/m/o$4;->b:Lchat/ola/vn/message/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onItemClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)V
    .locals 6
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
    iget-object p1, p0, Lchat/ola/vn/m/o$4;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/m/o$4;->c:Lchat/ola/vn/m/o;

    const p3, 0x7f0f05af

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/4 p3, 0x1

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/o$4;->b:Lchat/ola/vn/message/f;

    invoke-static {p3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p2

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/f;->a(Ljava/lang/Boolean;)V

    sget-object p1, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    if-eqz p1, :cond_2

    sget-object p1, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object p2, p0, Lchat/ola/vn/m/o$4;->b:Lchat/ola/vn/message/f;

    invoke-virtual {p1, p2}, Lchat/ola/vn/balloon/OlaBalloonService;->a(Lchat/ola/vn/message/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :try_start_1
    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object p2, p0, Lchat/ola/vn/m/o$4;->b:Lchat/ola/vn/message/f;

    invoke-virtual {p1, p2}, Lchat/ola/vn/message/g;->c(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :try_start_2
    sget-object p1, Lchat/ola/vn/OlaApplication;->c:Lchat/ola/vn/balloon/OlaBalloonService;

    iget-object p2, p0, Lchat/ola/vn/m/o$4;->b:Lchat/ola/vn/message/f;

    invoke-virtual {p1, p2}, Lchat/ola/vn/balloon/OlaBalloonService;->c(Lchat/ola/vn/message/f;)V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/m/o$4;->c:Lchat/ola/vn/m/o;

    const p4, 0x7f0f05ce

    invoke-virtual {p2, p4}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/o$4;->c:Lchat/ola/vn/m/o;

    invoke-virtual {p1}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object p1, p0, Lchat/ola/vn/m/o$4;->c:Lchat/ola/vn/m/o;

    invoke-virtual {p1, p4}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object p1, p0, Lchat/ola/vn/m/o$4;->c:Lchat/ola/vn/m/o;

    const p2, 0x7f0f01d6

    new-array p3, p3, [Ljava/lang/Object;

    const/4 p5, 0x0

    iget-object v2, p0, Lchat/ola/vn/m/o$4;->b:Lchat/ola/vn/message/f;

    invoke-virtual {v2}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object v2

    aput-object v2, p3, p5

    invoke-virtual {p1, p2, p3}, Lchat/ola/vn/m/o;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iget-object p1, p0, Lchat/ola/vn/m/o$4;->c:Lchat/ola/vn/m/o;

    invoke-virtual {p1, p4}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object p1, p0, Lchat/ola/vn/m/o$4;->c:Lchat/ola/vn/m/o;

    const p2, 0x7f0f044d

    invoke-virtual {p1, p2}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/m/o$4$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/m/o$4$1;-><init>(Lchat/ola/vn/m/o$4;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/m/o$4;->c:Lchat/ola/vn/m/o;

    const p3, 0x7f0f04ad

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    new-instance p1, Lchat/ola/vn/i/h;

    iget-object p2, p0, Lchat/ola/vn/m/o$4;->c:Lchat/ola/vn/m/o;

    invoke-virtual {p2}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/m/o$4;->c:Lchat/ola/vn/m/o;

    const p4, 0x7f0f009c

    invoke-virtual {p3, p4}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p3

    iget-object p4, p0, Lchat/ola/vn/m/o$4;->c:Lchat/ola/vn/m/o;

    const p5, 0x7f0f021c

    invoke-virtual {p4, p5}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p4

    new-instance p5, Lchat/ola/vn/m/o$4$2;

    invoke-direct {p5, p0}, Lchat/ola/vn/m/o$4$2;-><init>(Lchat/ola/vn/m/o$4;)V

    invoke-direct {p1, p2, p3, p4, p5}, Lchat/ola/vn/i/h;-><init>(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/i/h$a;)V

    invoke-virtual {p1}, Lchat/ola/vn/i/h;->show()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :catch_1
    :cond_2
    return-void
.end method
