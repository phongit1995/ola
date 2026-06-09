.class Lchat/ola/vn/me/OlaMeComposerActivity$21;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AdapterView$OnItemClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/OlaMeComposerActivity;->P()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Lchat/ola/vn/me/OlaMeComposerActivity;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/OlaMeComposerActivity;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    iput-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->a:Ljava/util/List;

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
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->a:Ljava/util/List;

    invoke-interface {p1, p3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/String;

    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    const p3, 0x7f0f05bb

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    const/4 p2, 0x2

    invoke-static {p1, p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Lchat/ola/vn/me/OlaMeComposerActivity;S)S

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->e(Lchat/ola/vn/me/OlaMeComposerActivity;)S

    move-result p1

    sput-short p1, Lchat/ola/vn/c/x;->j:S

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    :goto_0
    sget-short p2, Lchat/ola/vn/c/x;->j:S

    invoke-virtual {p1, p2}, Lchat/ola/vn/e;->d(I)V

    goto/16 :goto_2

    :cond_0
    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    const p3, 0x7f0f0501

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    const/4 p2, 0x1

    invoke-static {p1, p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Lchat/ola/vn/me/OlaMeComposerActivity;S)S

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->e(Lchat/ola/vn/me/OlaMeComposerActivity;)S

    move-result p1

    sput-short p1, Lchat/ola/vn/c/x;->j:S

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    goto :goto_0

    :cond_1
    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    const p3, 0x7f0f051f

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_2

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    const/4 p2, 0x3

    invoke-static {p1, p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Lchat/ola/vn/me/OlaMeComposerActivity;S)S

    goto :goto_2

    :cond_2
    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    const p3, 0x7f0f043f

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_3

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    const/16 p2, 0xb

    invoke-static {p1, p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Lchat/ola/vn/me/OlaMeComposerActivity;S)S

    goto :goto_2

    :cond_3
    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    const p3, 0x7f0f04bb

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    const/16 p4, 0xa

    if-eqz p2, :cond_4

    :goto_1
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {p1, p4}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Lchat/ola/vn/me/OlaMeComposerActivity;S)S

    goto :goto_2

    :cond_4
    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p2

    if-eqz p2, :cond_5

    goto :goto_1

    :cond_5
    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    const p3, 0x7f0f05bf

    invoke-virtual {p2, p3}, Lchat/ola/vn/me/OlaMeComposerActivity;->getString(I)Ljava/lang/String;

    move-result-object p2

    invoke-static {p1, p2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_6

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    iget-object p2, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->e(Lchat/ola/vn/me/OlaMeComposerActivity;)S

    move-result p2

    or-int/lit16 p2, p2, 0x4000

    int-to-short p2, p2

    invoke-static {p1, p2}, Lchat/ola/vn/me/OlaMeComposerActivity;->a(Lchat/ola/vn/me/OlaMeComposerActivity;S)S

    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->e(Lchat/ola/vn/me/OlaMeComposerActivity;)S

    move-result p1

    sput-short p1, Lchat/ola/vn/c/x;->j:S

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    goto/16 :goto_0

    :cond_6
    :goto_2
    iget-object p1, p0, Lchat/ola/vn/me/OlaMeComposerActivity$21;->b:Lchat/ola/vn/me/OlaMeComposerActivity;

    invoke-static {p1}, Lchat/ola/vn/me/OlaMeComposerActivity;->f(Lchat/ola/vn/me/OlaMeComposerActivity;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
