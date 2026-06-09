.class public Lchat/ola/vn/view/h;
.super Lchat/ola/vn/view/d;

# interfaces
.implements Landroid/support/v4/view/ViewPager$OnPageChangeListener;
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/view/h$b;,
        Lchat/ola/vn/view/h$a;
    }
.end annotation


# static fields
.field private static c:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/h;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field protected a:Lchat/ola/vn/view/h$b;

.field b:Lchat/ola/vn/b/ab;

.field private d:Landroid/support/v4/view/ViewPager;

.field private e:[Landroid/widget/ImageView;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0, p1}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;)V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/view/h;->b:Lchat/ola/vn/b/ab;

    invoke-direct {p0, p1}, Lchat/ola/vn/view/h;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/view/h;->b:Lchat/ola/vn/b/ab;

    invoke-direct {p0, p1}, Lchat/ola/vn/view/h;->a(Landroid/content/Context;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lchat/ola/vn/view/d;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/view/h;->b:Lchat/ola/vn/b/ab;

    invoke-direct {p0, p1}, Lchat/ola/vn/view/h;->a(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic a(Ljava/util/List;)Ljava/util/List;
    .locals 0

    sput-object p0, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    return-object p0
.end method

.method private a(I)V
    .locals 4

    const/4 v0, 0x0

    const/4 v1, 0x0

    :goto_0
    :try_start_0
    iget-object v2, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    array-length v2, v2

    if-ge v1, v2, :cond_3

    if-ne v1, p1, :cond_0

    iget-object v2, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object v2, v2, v1

    sget v3, Lchat/ola/vn/f;->M:I

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setBackgroundColor(I)V

    goto :goto_1

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object v2, v2, v1

    invoke-virtual {v2, v0}, Landroid/widget/ImageView;->setBackgroundColor(I)V

    :goto_1
    if-nez v1, :cond_2

    if-ne v1, p1, :cond_1

    iget-object v2, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object v2, v2, v1

    const v3, 0x7f08076d

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setImageResource(I)V

    goto :goto_2

    :cond_1
    iget-object v2, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object v2, v2, v1

    const v3, 0x7f08076c

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setImageResource(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_2
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :catch_0
    :cond_3
    return-void
.end method

.method private a(Landroid/content/Context;)V
    .locals 7

    const v0, 0x7f0b0138

    invoke-static {p1, v0, p0}, Lchat/ola/vn/view/h;->inflate(Landroid/content/Context;ILandroid/view/ViewGroup;)Landroid/view/View;

    const p1, 0x7f090482

    :try_start_0
    invoke-virtual {p0, p1}, Lchat/ola/vn/view/h;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/support/v4/view/ViewPager;

    iput-object p1, p0, Lchat/ola/vn/view/h;->d:Landroid/support/v4/view/ViewPager;

    const/4 p1, 0x6

    new-array p1, p1, [Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    iget-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    const v0, 0x7f09047c

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/h;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    const/4 v1, 0x0

    aput-object v0, p1, v1

    iget-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    const v0, 0x7f09047d

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/h;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    const/4 v2, 0x1

    aput-object v0, p1, v2

    iget-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    const v0, 0x7f09047e

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/h;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    const/4 v3, 0x2

    aput-object v0, p1, v3

    iget-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    const v0, 0x7f09047f

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/h;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    const/4 v4, 0x3

    aput-object v0, p1, v4

    iget-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    const v0, 0x7f090480

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/h;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    const/4 v5, 0x4

    aput-object v0, p1, v5

    iget-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    const v0, 0x7f090481

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/h;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    const/4 v6, 0x5

    aput-object v0, p1, v6

    iget-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object p1, p1, v1

    invoke-virtual {p1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object p1, p1, v2

    invoke-virtual {p1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object p1, p1, v3

    invoke-virtual {p1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object p1, p1, v4

    invoke-virtual {p1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object p1, p1, v5

    invoke-virtual {p1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object p1, p1, v6

    invoke-virtual {p1, p0}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object p1, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object p1, p1, v1

    const v0, 0x7f08076c

    invoke-virtual {p1, v0}, Landroid/widget/ImageView;->setImageResource(I)V

    new-instance p1, Ljava/util/Random;

    invoke-direct {p1}, Ljava/util/Random;-><init>()V

    sget-object v0, Lchat/ola/vn/r/c;->a:[Lchat/ola/vn/entry/h;

    array-length v0, v0

    invoke-virtual {p1, v0}, Ljava/util/Random;->nextInt(I)I

    move-result p1

    sget-object v0, Lchat/ola/vn/r/c;->a:[Lchat/ola/vn/entry/h;

    aget-object p1, v0, p1

    iget-object v0, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object v0, v0, v2

    iget p1, p1, Lchat/ola/vn/entry/h;->d:I

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    new-instance p1, Ljava/util/Random;

    invoke-direct {p1}, Ljava/util/Random;-><init>()V

    sget-object v0, Lchat/ola/vn/r/c;->d:[Lchat/ola/vn/entry/h;

    array-length v0, v0

    invoke-virtual {p1, v0}, Ljava/util/Random;->nextInt(I)I

    move-result p1

    sget-object v0, Lchat/ola/vn/r/c;->d:[Lchat/ola/vn/entry/h;

    aget-object p1, v0, p1

    iget-object v0, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object v0, v0, v3

    iget p1, p1, Lchat/ola/vn/entry/h;->d:I

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    new-instance p1, Ljava/util/Random;

    invoke-direct {p1}, Ljava/util/Random;-><init>()V

    sget-object v0, Lchat/ola/vn/r/c;->e:[Lchat/ola/vn/entry/h;

    array-length v0, v0

    invoke-virtual {p1, v0}, Ljava/util/Random;->nextInt(I)I

    move-result p1

    sget-object v0, Lchat/ola/vn/r/c;->e:[Lchat/ola/vn/entry/h;

    aget-object p1, v0, p1

    iget-object v0, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object v0, v0, v4

    iget p1, p1, Lchat/ola/vn/entry/h;->d:I

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    new-instance p1, Ljava/util/Random;

    invoke-direct {p1}, Ljava/util/Random;-><init>()V

    sget-object v0, Lchat/ola/vn/r/c;->c:[Lchat/ola/vn/entry/h;

    array-length v0, v0

    invoke-virtual {p1, v0}, Ljava/util/Random;->nextInt(I)I

    move-result p1

    sget-object v0, Lchat/ola/vn/r/c;->c:[Lchat/ola/vn/entry/h;

    aget-object p1, v0, p1

    iget-object v0, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object v0, v0, v5

    iget p1, p1, Lchat/ola/vn/entry/h;->d:I

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    new-instance p1, Ljava/util/Random;

    invoke-direct {p1}, Ljava/util/Random;-><init>()V

    sget-object v0, Lchat/ola/vn/r/c;->b:[Lchat/ola/vn/entry/h;

    array-length v0, v0

    invoke-virtual {p1, v0}, Ljava/util/Random;->nextInt(I)I

    move-result p1

    sget-object v0, Lchat/ola/vn/r/c;->b:[Lchat/ola/vn/entry/h;

    aget-object p1, v0, p1

    iget-object v0, p0, Lchat/ola/vn/view/h;->e:[Landroid/widget/ImageView;

    aget-object v0, v0, v6

    iget p1, p1, Lchat/ola/vn/entry/h;->d:I

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageResource(I)V

    iget-object p1, p0, Lchat/ola/vn/view/h;->d:Landroid/support/v4/view/ViewPager;

    new-instance v0, Lchat/ola/vn/view/h$a;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lchat/ola/vn/view/h$a;-><init>(Lchat/ola/vn/view/h;Lchat/ola/vn/view/h$1;)V

    invoke-virtual {p1, v0}, Landroid/support/v4/view/ViewPager;->setAdapter(Landroid/support/v4/view/PagerAdapter;)V

    iget-object p1, p0, Lchat/ola/vn/view/h;->d:Landroid/support/v4/view/ViewPager;

    invoke-virtual {p1, p0}, Landroid/support/v4/view/ViewPager;->setOnPageChangeListener(Landroid/support/v4/view/ViewPager$OnPageChangeListener;)V

    sget-object p1, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    if-nez p1, :cond_0

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    sput-object p1, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/e;->x()Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_0

    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    sget-object v0, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    :cond_0
    invoke-virtual {p0, v2}, Lchat/ola/vn/view/h;->setCurrentTab(I)V

    const p1, 0x7f090087

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/h;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p1, p0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method static synthetic b()Ljava/util/List;
    .locals 1

    sget-object v0, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    return-object v0
.end method


# virtual methods
.method public getOlaSmileyListener()Lchat/ola/vn/view/h$b;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/view/h;->a:Lchat/ola/vn/view/h$b;

    return-object v0
.end method

.method public onClick(Landroid/view/View;)V
    .locals 5

    :try_start_0
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const v1, 0x7f090087

    if-eq v0, v1, :cond_3

    const/4 v1, 0x1

    const/4 v2, 0x0

    packed-switch v0, :pswitch_data_0

    const/4 v0, 0x0

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/h;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    iput-wide v3, p1, Lchat/ola/vn/entry/h;->a:J

    iget-short v3, p1, Lchat/ola/vn/entry/h;->c:S

    packed-switch v3, :pswitch_data_1

    goto :goto_0

    :pswitch_0
    invoke-virtual {p1}, Lchat/ola/vn/entry/h;->b()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v0

    invoke-static {v0}, Ljava/lang/String;->valueOf([C)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :pswitch_1
    iget-object v0, p1, Lchat/ola/vn/entry/h;->b:[Ljava/lang/String;

    aget-object v0, v0, v2

    :goto_0
    :pswitch_2
    iget-object v2, p0, Lchat/ola/vn/view/h;->a:Lchat/ola/vn/view/h$b;

    if-eqz v2, :cond_0

    iget-object v2, p0, Lchat/ola/vn/view/h;->a:Lchat/ola/vn/view/h$b;

    invoke-interface {v2, v0}, Lchat/ola/vn/view/h$b;->g(Ljava/lang/String;)V

    :cond_0
    sget-object v0, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->indexOf(Ljava/lang/Object;)I

    move-result v0

    if-gez v0, :cond_2

    sget-object v0, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const/16 v2, 0x1e

    if-lt v0, v2, :cond_1

    sget-object v0, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    sget-object v2, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    sub-int/2addr v2, v1

    invoke-interface {v0, v2}, Ljava/util/List;->remove(I)Ljava/lang/Object;

    :cond_1
    sget-object v0, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    sget-object p1, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    new-instance v0, Lchat/ola/vn/e/j;

    invoke-direct {v0}, Lchat/ola/vn/e/j;-><init>()V

    invoke-static {p1, v0}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    goto :goto_1

    :cond_2
    sget-object p1, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    invoke-interface {p1, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/h;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p1, Lchat/ola/vn/entry/h;->a:J

    :goto_1
    invoke-static {}, Lchat/ola/vn/e;->a()Lchat/ola/vn/e;

    move-result-object p1

    sget-object v0, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    invoke-virtual {p1, v0}, Lchat/ola/vn/e;->c(Ljava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    iget-object p1, p0, Lchat/ola/vn/view/h;->b:Lchat/ola/vn/b/ab;

    invoke-virtual {p1}, Lchat/ola/vn/b/ab;->notifyDataSetChanged()V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_1

    return-void

    :pswitch_3
    const/4 p1, 0x5

    :try_start_2
    invoke-virtual {p0, p1}, Lchat/ola/vn/view/h;->setCurrentTab(I)V

    return-void

    :pswitch_4
    const/4 p1, 0x4

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/h;->setCurrentTab(I)V

    return-void

    :pswitch_5
    const/4 p1, 0x3

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/h;->setCurrentTab(I)V

    return-void

    :pswitch_6
    const/4 p1, 0x2

    invoke-virtual {p0, p1}, Lchat/ola/vn/view/h;->setCurrentTab(I)V

    return-void

    :pswitch_7
    invoke-virtual {p0, v1}, Lchat/ola/vn/view/h;->setCurrentTab(I)V

    return-void

    :pswitch_8
    invoke-virtual {p0, v2}, Lchat/ola/vn/view/h;->setCurrentTab(I)V

    return-void

    :cond_3
    iget-object p1, p0, Lchat/ola/vn/view/h;->a:Lchat/ola/vn/view/h$b;

    if-eqz p1, :cond_4

    iget-object p1, p0, Lchat/ola/vn/view/h;->a:Lchat/ola/vn/view/h$b;

    invoke-interface {p1}, Lchat/ola/vn/view/h$b;->L()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_1
    :cond_4
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x7f09047c
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_1
        :pswitch_0
        :pswitch_2
    .end packed-switch
.end method

.method public onInterceptTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 1

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lchat/ola/vn/view/h;->requestDisallowInterceptTouchEvent(Z)V

    invoke-super {p0, p1}, Lchat/ola/vn/view/d;->onInterceptTouchEvent(Landroid/view/MotionEvent;)Z

    move-result p1

    return p1
.end method

.method public onPageScrollStateChanged(I)V
    .locals 0

    return-void
.end method

.method public onPageScrolled(IFI)V
    .locals 0

    return-void
.end method

.method public onPageSelected(I)V
    .locals 2

    if-nez p1, :cond_0

    :try_start_0
    sget-object v0, Lchat/ola/vn/view/h;->c:Ljava/util/List;

    new-instance v1, Lchat/ola/vn/e/j;

    invoke-direct {v1}, Lchat/ola/vn/e/j;-><init>()V

    invoke-static {v0, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    iget-object v0, p0, Lchat/ola/vn/view/h;->b:Lchat/ola/vn/b/ab;

    invoke-virtual {v0}, Lchat/ola/vn/b/ab;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    invoke-direct {p0, p1}, Lchat/ola/vn/view/h;->a(I)V

    return-void
.end method

.method public setCurrentTab(I)V
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/view/h;->d:Landroid/support/v4/view/ViewPager;

    const/4 v1, 0x1

    invoke-virtual {v0, p1, v1}, Landroid/support/v4/view/ViewPager;->setCurrentItem(IZ)V

    invoke-direct {p0, p1}, Lchat/ola/vn/view/h;->a(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-void
.end method

.method public setOlaSmileyListener(Lchat/ola/vn/view/h$b;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/view/h;->a:Lchat/ola/vn/view/h$b;

    return-void
.end method
