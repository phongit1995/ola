.class Lchat/ola/vn/m/o$5;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/o;->d(Lchat/ola/vn/message/f;Landroid/view/View;Landroid/content/Context;)V
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

    iput-object p1, p0, Lchat/ola/vn/m/o$5;->c:Lchat/ola/vn/m/o;

    iput-object p2, p0, Lchat/ola/vn/m/o$5;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/m/o$5;->b:Lchat/ola/vn/message/f;

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
    iget-object p1, p0, Lchat/ola/vn/m/o$5;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/m/o$5;->c:Lchat/ola/vn/m/o;

    const p3, 0x7f0f05cc

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/o$5;->c:Lchat/ola/vn/m/o;

    invoke-virtual {p1}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object p1, p0, Lchat/ola/vn/m/o$5;->c:Lchat/ola/vn/m/o;

    invoke-virtual {p1, p3}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object p1, p0, Lchat/ola/vn/m/o$5;->c:Lchat/ola/vn/m/o;

    const p2, 0x7f0f030e

    const/4 p3, 0x1

    new-array p3, p3, [Ljava/lang/Object;

    const/4 p4, 0x0

    iget-object p5, p0, Lchat/ola/vn/m/o$5;->b:Lchat/ola/vn/message/f;

    invoke-virtual {p5}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object p5

    aput-object p5, p3, p4

    invoke-virtual {p1, p2, p3}, Lchat/ola/vn/m/o;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    iget-object p1, p0, Lchat/ola/vn/m/o$5;->c:Lchat/ola/vn/m/o;

    const p2, 0x7f0f06c2

    invoke-virtual {p1, p2}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object p1, p0, Lchat/ola/vn/m/o$5;->c:Lchat/ola/vn/m/o;

    const p2, 0x7f0f0577

    invoke-virtual {p1, p2}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/m/o$5$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/m/o$5$1;-><init>(Lchat/ola/vn/m/o$5;)V

    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
