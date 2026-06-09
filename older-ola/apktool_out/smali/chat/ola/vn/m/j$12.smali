.class Lchat/ola/vn/m/j$12;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/j;->a(Lchat/ola/vn/entity/t;Z)Landroid/app/Dialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/entity/t;

.field final synthetic c:Z

.field final synthetic d:Lchat/ola/vn/m/j;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/j;Ljava/util/List;Lchat/ola/vn/entity/t;Z)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    iput-object p2, p0, Lchat/ola/vn/m/j$12;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/m/j$12;->b:Lchat/ola/vn/entity/t;

    iput-boolean p4, p0, Lchat/ola/vn/m/j$12;->c:Z

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
    iget-object p1, p0, Lchat/ola/vn/m/j$12;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    const p3, 0x7f0f04cd

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    new-instance p1, Lchat/ola/vn/i/a;

    iget-object p2, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    invoke-virtual {p2}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    iget-object p3, p0, Lchat/ola/vn/m/j$12;->b:Lchat/ola/vn/entity/t;

    invoke-direct {p1, p2, p3}, Lchat/ola/vn/i/a;-><init>(Landroid/content/Context;Lchat/ola/vn/entity/t;)V

    invoke-virtual {p1}, Lchat/ola/vn/i/a;->show()V

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    const p3, 0x7f0f04a6

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-boolean p1, p0, Lchat/ola/vn/m/j$12;->c:Z

    const p2, 0x7f0f0480

    const p4, 0x7f0f00a2

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    invoke-virtual {p1}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object p1, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    invoke-virtual {p1, p4}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object p1, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    const p4, 0x7f0f01ed

    invoke-virtual {p1, p4}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v2

    iget-object p1, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    invoke-virtual {p1, p3}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object p1, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    invoke-virtual {p1, p2}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/m/j$12$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/m/j$12$1;-><init>(Lchat/ola/vn/m/j$12;)V

    :goto_0
    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lchat/ola/vn/i/f;

    return-void

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    invoke-virtual {p1}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    iget-object p1, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    invoke-virtual {p1, p4}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v1

    iget-object p1, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    const p4, 0x7f0f01ee

    invoke-virtual {p1, p4}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v2

    iget-object p1, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    invoke-virtual {p1, p3}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v3

    iget-object p1, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    invoke-virtual {p1, p2}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lchat/ola/vn/m/j$12$2;

    invoke-direct {v5, p0}, Lchat/ola/vn/m/j$12$2;-><init>(Lchat/ola/vn/m/j$12;)V

    goto :goto_0

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    const p3, 0x7f0f0491

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/j;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    iget-object p1, p0, Lchat/ola/vn/m/j$12;->b:Lchat/ola/vn/entity/t;

    invoke-virtual {p1}, Lchat/ola/vn/entity/t;->o()Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_3

    new-instance p2, Ljava/lang/StringBuilder;

    invoke-direct {p2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p3, ""

    invoke-virtual {p2, p3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    const-string p3, "null"

    invoke-static {p2, p3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-nez p2, :cond_3

    iget-object p2, p0, Lchat/ola/vn/m/j$12;->d:Lchat/ola/vn/m/j;

    invoke-virtual {p2}, Lchat/ola/vn/m/j;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    new-instance p3, Ljava/lang/StringBuilder;

    invoke-direct {p3}, Ljava/lang/StringBuilder;-><init>()V

    const-string p4, "rss://"

    invoke-virtual {p3, p4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p2, p1}, Lchat/ola/vn/util/o;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_3
    return-void
.end method
