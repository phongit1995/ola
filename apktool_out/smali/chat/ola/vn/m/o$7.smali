.class Lchat/ola/vn/m/o$7;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/o;->h_()Landroid/app/Dialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/m/o;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/o;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/o$7;->b:Lchat/ola/vn/m/o;

    iput-object p2, p0, Lchat/ola/vn/m/o$7;->a:Ljava/util/List;

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
    iget-object p1, p0, Lchat/ola/vn/m/o$7;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/m/o$7;->b:Lchat/ola/vn/m/o;

    const p3, 0x7f0f04aa

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/o$7;->b:Lchat/ola/vn/m/o;

    invoke-virtual {p1}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f009b

    const v2, 0x7f0f04ab

    const v3, 0x7f0f04a6

    const v4, 0x7f0f0577

    new-instance v5, Lchat/ola/vn/m/o$7$1;

    invoke-direct {v5, p0}, Lchat/ola/vn/m/o$7$1;-><init>(Lchat/ola/vn/m/o$7;)V

    :goto_0
    invoke-static/range {v0 .. v5}, Lchat/ola/vn/i/i;->d(Landroid/content/Context;IIIILandroid/content/DialogInterface$OnClickListener;)Landroid/app/Dialog;

    return-void

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/m/o$7;->b:Lchat/ola/vn/m/o;

    const p3, 0x7f0f04a9

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/o$7;->b:Lchat/ola/vn/m/o;

    invoke-virtual {p1}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    const v1, 0x7f0f009b

    const v2, 0x7f0f0215

    const v3, 0x7f0f04a6

    const v4, 0x7f0f0577

    new-instance v5, Lchat/ola/vn/m/o$7$2;

    invoke-direct {v5, p0}, Lchat/ola/vn/m/o$7$2;-><init>(Lchat/ola/vn/m/o$7;)V

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/m/o$7;->b:Lchat/ola/vn/m/o;

    const p3, 0x7f0f043b

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/m/o$7;->b:Lchat/ola/vn/m/o;

    invoke-virtual {p1}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/message/OlaChatBlockedListActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/m/o$7;->b:Lchat/ola/vn/m/o;

    const p3, 0x7f0f062d

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    sget-boolean p1, Lchat/ola/vn/c/x;->v:Z

    if-eqz p1, :cond_4

    const/4 p1, 0x0

    sput-boolean p1, Lchat/ola/vn/c/x;->v:Z

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    sget-boolean p2, Lchat/ola/vn/c/x;->v:Z

    invoke-static {p1, p2}, Lchat/ola/vn/h/b;->c(Ljava/lang/String;Z)V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->c()V

    iget-object p1, p0, Lchat/ola/vn/m/o$7;->b:Lchat/ola/vn/m/o;

    :goto_1
    invoke-static {p1}, Lchat/ola/vn/m/o;->a(Lchat/ola/vn/m/o;)Lchat/ola/vn/b/r;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    return-void

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/m/o$7;->b:Lchat/ola/vn/m/o;

    const p3, 0x7f0f0513

    invoke-virtual {p2, p3}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p2, p1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    sget-boolean p1, Lchat/ola/vn/c/x;->v:Z

    if-nez p1, :cond_4

    const/4 p1, 0x1

    sput-boolean p1, Lchat/ola/vn/c/x;->v:Z

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object p1

    sget-boolean p2, Lchat/ola/vn/c/x;->v:Z

    invoke-static {p1, p2}, Lchat/ola/vn/h/b;->c(Ljava/lang/String;Z)V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1}, Lchat/ola/vn/message/g;->c()V

    iget-object p1, p0, Lchat/ola/vn/m/o$7;->b:Lchat/ola/vn/m/o;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    :cond_4
    return-void
.end method
