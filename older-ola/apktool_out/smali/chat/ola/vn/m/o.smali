.class public Lchat/ola/vn/m/o;
.super Lchat/ola/vn/m/p;

# interfaces
.implements Landroid/view/View$OnClickListener;
.implements Landroid/widget/AdapterView$OnItemClickListener;
.implements Landroid/widget/AdapterView$OnItemLongClickListener;
.implements Lchat/ola/vn/b/j$a;
.implements Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;
.implements Lchat/ola/vn/p/f;


# instance fields
.field private a:Landroid/os/Parcelable;

.field private b:Lit/sephiroth/android/library/widget/EnhancedListView;

.field private d:Landroid/view/View;

.field private e:Lchat/ola/vn/b/r;

.field private f:Landroid/view/View;


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Lchat/ola/vn/m/p;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/m/o;->a:Landroid/os/Parcelable;

    iput-object v0, p0, Lchat/ola/vn/m/o;->f:Landroid/view/View;

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/m/o;)Lchat/ola/vn/b/r;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    return-object p0
.end method

.method private a(Lchat/ola/vn/message/f;Landroid/content/Context;)V
    .locals 3

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f05af

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f04ad

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f0492

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f043a

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v1, 0x7f0f042f

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-direct {v1, p2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->setTitle(Ljava/lang/CharSequence;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/m/o$6;

    invoke-direct {v2, p0, v0, p1, p2}, Lchat/ola/vn/m/o$6;-><init>(Lchat/ola/vn/m/o;Ljava/util/List;Lchat/ola/vn/message/f;Landroid/content/Context;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private a(Lchat/ola/vn/message/f;Landroid/view/View;Landroid/content/Context;)V
    .locals 1

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    const v0, 0x7f0f04ad

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/i/m;

    invoke-direct {v0, p3}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance p3, Lchat/ola/vn/m/o$2;

    invoke-direct {p3, p0, p2, p1}, Lchat/ola/vn/m/o$2;-><init>(Lchat/ola/vn/m/o;Ljava/util/List;Lchat/ola/vn/message/f;)V

    invoke-virtual {v0, p3}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method static synthetic b(Lchat/ola/vn/m/o;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/o;->j()V

    return-void
.end method

.method private b(Lchat/ola/vn/message/f;Landroid/view/View;Landroid/content/Context;)V
    .locals 1

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    const v0, 0x7f0f05cc

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/i/m;

    invoke-direct {v0, p3}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance p3, Lchat/ola/vn/m/o$3;

    invoke-direct {p3, p0, p2, p1}, Lchat/ola/vn/m/o$3;-><init>(Lchat/ola/vn/m/o;Ljava/util/List;Lchat/ola/vn/message/f;)V

    invoke-virtual {v0, p3}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method static synthetic c(Lchat/ola/vn/m/o;)Landroid/view/View;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/m/o;->f:Landroid/view/View;

    return-object p0
.end method

.method private c()V
    .locals 3

    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    new-instance v1, Lchat/ola/vn/m/o$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/o$1;-><init>(Lchat/ola/vn/m/o;)V

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView$b;)Lit/sephiroth/android/library/widget/EnhancedListView;

    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->a()Lit/sephiroth/android/library/widget/EnhancedListView;

    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    const v1, 0x7f0901c7

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(I)Lit/sephiroth/android/library/widget/EnhancedListView;

    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    sget-object v1, Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;->a:Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView$UndoStyle;)Lit/sephiroth/android/library/widget/EnhancedListView;

    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Z)Lit/sephiroth/android/library/widget/EnhancedListView;

    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    const-wide/32 v1, 0x2bf20

    invoke-virtual {v0, v1, v2}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(J)Lit/sephiroth/android/library/widget/EnhancedListView;

    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    sget-object v1, Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;->c:Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/EnhancedListView;->a(Lit/sephiroth/android/library/widget/EnhancedListView$SwipeDirection;)Lit/sephiroth/android/library/widget/EnhancedListView;

    return-void
.end method

.method private c(Lchat/ola/vn/message/f;Landroid/view/View;Landroid/content/Context;)V
    .locals 1

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    const v0, 0x7f0f05af

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f04ad

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    const v0, 0x7f0f05ce

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/i/m;

    invoke-direct {v0, p3}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->b()Ljava/lang/String;

    move-result-object p3

    invoke-virtual {v0, p3}, Lchat/ola/vn/i/m;->a(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance p3, Lchat/ola/vn/m/o$4;

    invoke-direct {p3, p0, p2, p1}, Lchat/ola/vn/m/o$4;-><init>(Lchat/ola/vn/m/o;Ljava/util/List;Lchat/ola/vn/message/f;)V

    invoke-virtual {v0, p3}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private d(Lchat/ola/vn/message/f;Landroid/view/View;Landroid/content/Context;)V
    .locals 1

    new-instance p2, Ljava/util/ArrayList;

    invoke-direct {p2}, Ljava/util/ArrayList;-><init>()V

    const v0, 0x7f0f05cc

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-interface {p2, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v0, Lchat/ola/vn/i/m;

    invoke-direct {v0, p3}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance p3, Lchat/ola/vn/m/o$5;

    invoke-direct {p3, p0, p2, p1}, Lchat/ola/vn/m/o$5;-><init>(Lchat/ola/vn/m/o;Ljava/util/List;Lchat/ola/vn/message/f;)V

    invoke-virtual {v0, p3}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v0}, Lchat/ola/vn/i/m;->show()V

    return-void
.end method

.method private e()V
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/o;->g()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/e;

    invoke-virtual {v0}, Lchat/ola/vn/m/e;->e()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private j()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {v0}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    :cond_0
    invoke-direct {p0}, Lchat/ola/vn/m/o;->v()V

    invoke-direct {p0}, Lchat/ola/vn/m/o;->x()V

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/o;->a:Landroid/os/Parcelable;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    iget-object v1, p0, Lchat/ola/vn/m/o;->a:Landroid/os/Parcelable;

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/EnhancedListView;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/m/o;->a:Landroid/os/Parcelable;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method private v()V
    .locals 2

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/o;->g()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/e;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/m/e;->a(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method private x()V
    .locals 3

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->j()I

    move-result v0

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-lez v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-virtual {v0, v2}, Lit/sephiroth/android/library/widget/EnhancedListView;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/o;->d:Landroid/view/View;

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/o;->d:Landroid/view/View;

    invoke-virtual {v0, v2}, Landroid/view/View;->setVisibility(I)V

    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/EnhancedListView;->setVisibility(I)V

    return-void
.end method

.method private y()Ljava/lang/CharSequence;
    .locals 6

    const v0, 0x7f0f0273

    invoke-virtual {p0, v0}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_0

    const-string v0, ""

    return-object v0

    :cond_0
    new-instance v1, Landroid/text/SpannableString;

    invoke-direct {v1, v0}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    const-string v2, "<MESSAGE>"

    invoke-static {v2}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    :catch_0
    :goto_0
    invoke-virtual {v0}, Ljava/util/regex/Matcher;->find()Z

    move-result v2

    if-eqz v2, :cond_1

    :try_start_0
    new-instance v2, Landroid/text/style/ImageSpan;

    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v3

    const v4, 0x7f08068e

    const/4 v5, 0x0

    invoke-direct {v2, v3, v4, v5}, Landroid/text/style/ImageSpan;-><init>(Landroid/content/Context;II)V

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->start()I

    move-result v3

    invoke-virtual {v0}, Ljava/util/regex/Matcher;->end()I

    move-result v4

    const/16 v5, 0x21

    invoke-virtual {v1, v2, v3, v4, v5}, Landroid/text/SpannableString;->setSpan(Ljava/lang/Object;III)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :cond_1
    return-object v1
.end method


# virtual methods
.method public B()Z
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->F()Ljava/lang/String;

    move-result-object v0

    const-string v1, "null"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    return v0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public C()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {v0}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    invoke-direct {p0}, Lchat/ola/vn/m/o;->x()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public H()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public a(Landroid/content/Context;)Ljava/util/ArrayList;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/mediastore/a;",
            ">;"
        }
    .end annotation

    const/4 p1, 0x0

    return-object p1
.end method

.method protected a(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/m/p;->a(Landroid/os/Bundle;)V

    const/4 v0, 0x0

    :try_start_0
    iput-object v0, p0, Lchat/ola/vn/m/o;->a:Landroid/os/Parcelable;

    if-eqz p1, :cond_0

    const-string v0, "conversation_scroll_parcelable"

    invoke-virtual {p1, v0}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/o;->a:Landroid/os/Parcelable;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_0
    return-void
.end method

.method public a(Lchat/ola/vn/message/d;BB)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Lchat/ola/vn/message/f;ILjava/lang/String;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/message/f;",
            "I",
            "Ljava/lang/String;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;)V"
        }
    .end annotation

    iget-object p1, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    return-void
.end method

.method public a(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    return-void
.end method

.method public a(Lchat/ola/vn/message/f;Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lchat/ola/vn/message/f;",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/d;",
            ">;)V"
        }
    .end annotation

    iget-object p1, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    return-void
.end method

.method public a_()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {v0}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a_(I)V
    .locals 2

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->F()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    return-void

    :cond_0
    if-nez p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/m/o;->f:Landroid/view/View;

    const/4 v1, 0x4

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/m/o;->f:Landroid/view/View;

    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Landroid/view/View;->setVisibility(I)V

    :goto_0
    sget-object p1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    new-instance v1, Lchat/ola/vn/m/o$8;

    invoke-direct {v1, p0}, Lchat/ola/vn/m/o$8;-><init>(Lchat/ola/vn/m/o;)V

    invoke-static {v1}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v1

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/network/OlaNetworkService;->w(Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b(Landroid/content/Context;)Lchat/ola/vn/mediastore/a;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method protected b(Landroid/os/Bundle;)V
    .locals 1

    invoke-super {p0, p1}, Lchat/ola/vn/m/p;->b(Landroid/os/Bundle;)V

    :try_start_0
    new-instance p1, Lchat/ola/vn/b/r;

    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    invoke-direct {p1, v0}, Lchat/ola/vn/b/r;-><init>(Landroid/content/Context;)V

    iput-object p1, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    iget-object p1, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    iget-object v0, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {p1, v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->setAdapter(Landroid/widget/ListAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {p1, p0}, Lchat/ola/vn/b/r;->a(Lchat/ola/vn/b/j$a;)V

    sget-object p1, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p1, p0}, Lchat/ola/vn/message/g;->a(Lchat/ola/vn/p/f;)V

    invoke-direct {p0}, Lchat/ola/vn/m/o;->e()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public b(Lchat/ola/vn/message/f;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    invoke-direct {p0}, Lchat/ola/vn/m/o;->j()V

    return-void
.end method

.method public b(Lchat/ola/vn/message/f;Lchat/ola/vn/message/d;)V
    .locals 0

    return-void
.end method

.method public b(Ljava/lang/Short;I)V
    .locals 0

    return-void
.end method

.method public c(Landroid/content/Context;)Lchat/ola/vn/mediastore/a;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public c(I)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/o;->e()V

    return-void
.end method

.method public c(Lchat/ola/vn/message/f;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    return-void
.end method

.method public c(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    iget-object p1, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    return-void
.end method

.method public c(Z)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public d(Lchat/ola/vn/message/f;)V
    .locals 0

    iget-object p1, p0, Lchat/ola/vn/m/o;->e:Lchat/ola/vn/b/r;

    invoke-virtual {p1}, Lchat/ola/vn/b/r;->notifyDataSetChanged()V

    return-void
.end method

.method public e(Lchat/ola/vn/message/f;)V
    .locals 0

    return-void
.end method

.method public f(Lchat/ola/vn/message/f;)V
    .locals 0

    return-void
.end method

.method public f_()V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lit/sephiroth/android/library/widget/EnhancedListView;->smoothScrollToPosition(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public g(Lchat/ola/vn/message/f;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method

.method public h(Ljava/util/List;)V
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/message/f;",
            ">;)V"
        }
    .end annotation

    :try_start_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v0

    sget-object v1, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    const/4 v2, 0x0

    invoke-interface {p1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object p1

    invoke-static {v0, v1, p1, v2}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;S)V

    return-void

    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const v2, 0x7f0f0466

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    add-int/2addr v2, v1

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const v2, 0x7f0f0566

    invoke-static {v2}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v2

    sget-object v3, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v2, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sget-object v2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, ".chatgroup."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x2

    invoke-virtual {v2, v3, v4, v1}, Lchat/ola/vn/message/g;->b(Ljava/lang/String;SZ)Lchat/ola/vn/message/f;

    move-result-object v1

    invoke-virtual {v1, v0}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Lchat/ola/vn/message/f;->a(Ljava/util/List;)V

    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v1}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1, v4}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Ljava/lang/String;S)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public h_()Landroid/app/Dialog;
    .locals 3

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    const v1, 0x7f0f04a9

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    sget-boolean v1, Lchat/ola/vn/c/x;->v:Z

    if-eqz v1, :cond_0

    const v1, 0x7f0f062d

    :goto_0
    invoke-virtual {p0, v1}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_1

    :cond_0
    const v1, 0x7f0f04aa

    goto :goto_0

    :goto_1
    const v1, 0x7f0f043b

    invoke-virtual {p0, v1}, Lchat/ola/vn/m/o;->getString(I)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    new-instance v1, Lchat/ola/vn/i/m;

    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v2

    invoke-direct {v1, v2}, Lchat/ola/vn/i/m;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v0}, Lchat/ola/vn/i/m;->a(Ljava/util/List;)V

    new-instance v2, Lchat/ola/vn/m/o$7;

    invoke-direct {v2, p0, v0}, Lchat/ola/vn/m/o$7;-><init>(Lchat/ola/vn/m/o;Ljava/util/List;)V

    invoke-virtual {v1, v2}, Lchat/ola/vn/i/m;->a(Landroid/widget/AdapterView$OnItemClickListener;)V

    invoke-virtual {v1}, Lchat/ola/vn/i/m;->show()V

    return-object v1
.end method

.method public i()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public i_()Ljava/lang/String;
    .locals 1

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 3

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const v1, 0x7f090030

    if-eq v0, v1, :cond_3

    const v1, 0x7f090281

    if-eq v0, v1, :cond_0

    return-void

    :cond_0
    :try_start_1
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/message/f;

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->k()S

    move-result v1

    if-eqz v1, :cond_2

    const/4 v2, 0x4

    if-eq v1, v2, :cond_1

    return-void

    :cond_1
    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object v1

    invoke-direct {p0, v0, p1, v1}, Lchat/ola/vn/m/o;->d(Lchat/ola/vn/message/f;Landroid/view/View;Landroid/content/Context;)V

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->j()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v0}, Lchat/ola/vn/me/OlaUserMePageActivity;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :cond_3
    :try_start_2
    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1, p0}, Lchat/ola/vn/contactpicker/OlaContactPickerActivity;->a(Landroid/content/Context;Lchat/ola/vn/contactpicker/OlaContactPickerActivity$b;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 1

    const p3, 0x7f0b0081

    const/4 v0, 0x0

    invoke-virtual {p1, p3, p2, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p2

    const p3, 0x7f0901c9

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Lit/sephiroth/android/library/widget/EnhancedListView;

    iput-object p3, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    iget-object p3, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-virtual {p3, p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->setOnItemClickListener(Landroid/widget/AdapterView$OnItemClickListener;)V

    iget-object p3, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-virtual {p3, p0}, Lit/sephiroth/android/library/widget/EnhancedListView;->setOnItemLongClickListener(Landroid/widget/AdapterView$OnItemLongClickListener;)V

    const p3, 0x7f0901cc

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    iput-object p3, p0, Lchat/ola/vn/m/o;->d:Landroid/view/View;

    const p3, 0x7f0901cd

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    check-cast p3, Landroid/widget/TextView;

    invoke-direct {p0}, Lchat/ola/vn/m/o;->y()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {p3, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const p3, 0x7f090030

    invoke-virtual {p2, p3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p3

    invoke-virtual {p3, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    const p3, 0x7f0b00d1

    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p1, p3, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/m/o;->f:Landroid/view/View;

    iget-object p1, p0, Lchat/ola/vn/m/o;->f:Landroid/view/View;

    const/4 p3, 0x4

    invoke-virtual {p1, p3}, Landroid/view/View;->setVisibility(I)V

    iget-object p1, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    iget-object p3, p0, Lchat/ola/vn/m/o;->f:Landroid/view/View;

    invoke-virtual {p1, p3}, Lit/sephiroth/android/library/widget/EnhancedListView;->addFooterView(Landroid/view/View;)V

    invoke-direct {p0}, Lchat/ola/vn/m/o;->c()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p2

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-object p2
.end method

.method public onDetach()V
    .locals 1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0, p0}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/p/f;)V

    invoke-super {p0}, Lchat/ola/vn/m/p;->onDetach()V

    return-void
.end method

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
    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    if-eqz p1, :cond_3

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    const/4 p3, 0x5

    if-ne p2, p3, :cond_0

    :try_start_1
    move-object p2, p1

    check-cast p2, Lchat/ola/vn/message/u;

    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p3

    invoke-virtual {p2, p3}, Lchat/ola/vn/message/u;->a(Landroid/content/Context;)Z

    move-result p2

    if-eqz p2, :cond_3

    sget-object p2, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {p2, p1}, Lchat/ola/vn/message/g;->b(Lchat/ola/vn/message/f;)Lchat/ola/vn/message/f;
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :cond_0
    :try_start_2
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2

    const/4 p3, 0x6

    if-ne p2, p3, :cond_1

    return-void

    :cond_1
    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p2

    const/4 p3, 0x7

    if-ne p2, p3, :cond_2

    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/message/OlaOtherPeopleListActivity;->a(Landroid/content/Context;)V

    return-void

    :cond_2
    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    sget-object p3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-static {p2, p3, p1}, Lchat/ola/vn/activity/OlaChatViewActivity;->a(Landroid/content/Context;Lchat/ola/vn/network/OlaNetworkService;Lchat/ola/vn/message/f;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    :cond_3
    return-void
.end method

.method public onItemLongClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)Z
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/AdapterView<",
            "*>;",
            "Landroid/view/View;",
            "IJ)Z"
        }
    .end annotation

    :try_start_0
    invoke-virtual {p1}, Landroid/widget/AdapterView;->getAdapter()Landroid/widget/Adapter;

    move-result-object p1

    invoke-interface {p1, p3}, Landroid/widget/Adapter;->getItem(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/message/f;

    invoke-virtual {p1}, Lchat/ola/vn/message/f;->k()S

    move-result p3

    const/4 p4, 0x4

    const/4 p5, 0x1

    if-eq p3, p4, :cond_0

    packed-switch p3, :pswitch_data_0

    goto :goto_0

    :pswitch_0
    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p3

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/m/o;->c(Lchat/ola/vn/message/f;Landroid/view/View;Landroid/content/Context;)V

    return p5

    :pswitch_1
    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p3

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/m/o;->a(Lchat/ola/vn/message/f;Landroid/view/View;Landroid/content/Context;)V

    return p5

    :pswitch_2
    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p2

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/m/o;->a(Lchat/ola/vn/message/f;Landroid/content/Context;)V

    return p5

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/m/o;->getActivity()Landroid/support/v4/app/FragmentActivity;

    move-result-object p3

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/m/o;->b(Lchat/ola/vn/message/f;Landroid/view/View;Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return p5

    :catch_0
    :goto_0
    const/4 p1, 0x0

    return p1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public onPause()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->b()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-super {p0}, Lchat/ola/vn/m/p;->onPause()V

    return-void
.end method

.method public onResume()V
    .locals 0

    invoke-super {p0}, Lchat/ola/vn/m/p;->onResume()V

    invoke-direct {p0}, Lchat/ola/vn/m/o;->j()V

    return-void
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/o;->b:Lit/sephiroth/android/library/widget/EnhancedListView;

    invoke-virtual {v0}, Lit/sephiroth/android/library/widget/EnhancedListView;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v0

    if-eqz v0, :cond_0

    const-string v1, "conversation_scroll_parcelable"

    invoke-virtual {p1, v1, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    invoke-super {p0, p1}, Lchat/ola/vn/m/p;->onSaveInstanceState(Landroid/os/Bundle;)V

    return-void
.end method
